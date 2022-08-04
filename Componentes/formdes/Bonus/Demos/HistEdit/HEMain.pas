(*  GREATIS BONUS * THistoryEdit              *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit HEMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmMain = class(TForm)
    btnDemo: TButton;
    procedure btnDemoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Run;

{$R *.DFM}

procedure TfrmMain.btnDemoClick(Sender: TObject);
begin
  frmRun.ShowModal;
end;

end.
