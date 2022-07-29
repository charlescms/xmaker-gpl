(*  GREATIS FORM DESIGNER DEMO                    *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Related;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellAPI;

type
  TfrmRelated = class(TForm)
    pnlObjectInspector: TPanel;
    lblObjectInspector: TLabel;
    lblObjectInspectorWeb: TLabel;
    btnOK: TButton;
    procedure lblObjectInspectorWebClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelated: TfrmRelated;

implementation

{$R *.DFM}

procedure TfrmRelated.lblObjectInspectorWebClick(Sender: TObject);
begin
  with Sender as TLabel do
    ShellExecute(Application.Handle,nil,PChar(Hint),nil,nil,SW_SHOWDEFAULT);
end;

end.
