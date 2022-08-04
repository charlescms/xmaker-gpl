(*  GREATIS BONUS * TIconList                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit ILMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IconList, ExtCtrls, StdCtrls, ComCtrls, ImgList, ToolWin;

type
  TfrmMain = class(TForm)
    iclDemo: TIconList;
    tbrDemo: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure ToolButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.ToolButtonClick(Sender: TObject);
begin
  ShowMessage('Images on all of these buttons loaded at runtime'#13'and... NOT STORED IN EXECUTABLE FILE !');
end;

end.
