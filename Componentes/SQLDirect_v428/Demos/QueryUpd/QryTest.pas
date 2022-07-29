unit QryTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, SDEngine, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons;

type
  TQueryTestFrm = class(TForm)
    pnlQuery: TPanel;
    pnlGrid: TPanel;
    grdQuery: TDBGrid;
    dsQuery: TDataSource;
    lblQuery: TLabel;
    meQuery: TMemo;
    btOpen: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QueryTestFrm: TQueryTestFrm;

implementation

{$R *.DFM}

uses
  DataMod;

procedure TQueryTestFrm.FormCreate(Sender: TObject);
begin
  with dmData do
    meQuery.Lines.Assign(qryQuery.SQL);
end;

procedure TQueryTestFrm.btOpenClick(Sender: TObject);
begin
  with dmData do begin
    qryQuery.Close;
    qryQuery.SQL.Assign(meQuery.Lines);
    qryQuery.Open;
    meQuery.SetFocus;
  end;
end;


end.
