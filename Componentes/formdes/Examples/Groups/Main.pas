(*  GREATIS FORM DESIGNER PRO                 *)
(*  Copyright (C) 2001-2002 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FDMain, StdCtrls;

type
  TfrmMain = class(TForm)
    cmpDesigner: TFormDesigner;
    lblCustomerID: TLabel;
    edtCustomerID: TEdit;
    lblOrderID: TLabel;
    edtOrderID: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure cmpDesignerAddControl(Sender: TObject;
      TheControl: TControl);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  cmpDesigner.Active:=True;
end;

procedure TfrmMain.cmpDesignerAddControl(Sender: TObject;
  TheControl: TControl);
var
  i: Integer;
begin
  // TheControl's Tag property value is used here
  // for identy other controls in the group,
  // of course, you can use another logic
  for i:=0 to Pred(ComponentCount) do
    if Components[i] is TControl then
      with TControl(Components[i]) do
        // if the control in the TheControl's group...
        if Visible and (Tag=TheControl.Tag) then
          // ...we add it to the selected control list
          cmpDesigner.AddControl(TControl(Self.Components[i]));
end;

end.
