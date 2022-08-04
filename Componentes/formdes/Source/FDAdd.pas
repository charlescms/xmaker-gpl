(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.001                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDAdd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TfrmFDAdd = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnSelectAll: TButton;
    lsbAddControls: TListBox;
    procedure lsvAddJobsEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure btnSelectAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmFDAdd.lsvAddJobsEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit:=False;
end;

procedure TfrmFDAdd.btnSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  with lsbAddControls,Items do
    for i:=0 to Pred(Count) do Selected[i]:=True;
end;

procedure TfrmFDAdd.FormShow(Sender: TObject);
begin
  with lsbAddControls,Items do
    if Count>0 then ItemIndex:=0;
end;

end.

