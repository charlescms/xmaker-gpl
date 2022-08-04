(*  GREATIS BONUS * Form Skin                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Dialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormSkin, StdCtrls;

type
  TfrmDialog = class(TForm)
    chbActive: TCheckBox;
    chbCaption: TCheckBox;
    chbBorder: TCheckBox;
    btnClose: TButton;
    lblInfo: TLabel;
    cmpSkin: TSimpleFormSkin;
    procedure btnCloseClick(Sender: TObject);
    procedure chbActiveClick(Sender: TObject);
    procedure chbCaptionClick(Sender: TObject);
    procedure chbBorderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDialog: TfrmDialog;

implementation

{$R *.DFM}

procedure TfrmDialog.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDialog.chbActiveClick(Sender: TObject);
begin
  with cmpSkin do Active:=not Active;
end;

procedure TfrmDialog.chbCaptionClick(Sender: TObject);
begin
  with cmpSkin do
    if chbCaption.Checked then Options:=Options+[soCaption]
    else Options:=Options-[soCaption];
end;

procedure TfrmDialog.chbBorderClick(Sender: TObject);
begin
  with cmpSkin do
    if chbBorder.Checked then Options:=Options+[soBorder]
    else Options:=Options-[soBorder];
end;

end.
