unit UpdTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Db, DBCtrls, Grids, DBGrids, ExtCtrls, SDEngine, SDOra;

type
  TUpdateTestFrm = class(TForm)
    pnlData: TPanel;
    pnlButtons: TPanel;
    grdPerson: TDBGrid;
    meNote: TDBMemo;
    DBNavigator: TDBNavigator;
    dsPerson: TDataSource;
    btApply: TButton;
    btClose: TBitBtn;
    cbFilter: TCheckBox;
    cbOra8Blobs: TCheckBox;
    procedure btCloseClick(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbFilterClick(Sender: TObject);
    procedure cbOra8BlobsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdateTestFrm: TUpdateTestFrm;

implementation

uses
  DataMod;

{$R *.DFM}

procedure TUpdateTestFrm.FormCreate(Sender: TObject);
begin
  with dmData do begin
    qryPersons.Open;

    cbOra8Blobs.Enabled := (Database.ServerType = stOracle) and (Database.ServerMajor >= 8) and (Database.ClientMajor >= 8);
    if cbOra8Blobs.Enabled then
      cbOra8Blobs.Checked := Oracle8Blobs;
  end;
end;

procedure TUpdateTestFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  mr: TModalResult;
begin
  CanClose := False;
  mr := mrYes;
  with dmData do begin
    if qryPersons.UpdatesPending then begin
      mr := MessageDlg('Save data ?', mtConfirmation, mbYesNoCancel, 0);
      if mr = mrYes then
        Database.ApplyUpdates([qryPersons]);
    end;
    if mr <> mrCancel then begin
      qryPersons.Close;
      CanClose := True;
    end;
  end;
end;

procedure TUpdateTestFrm.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TUpdateTestFrm.btApplyClick(Sender: TObject);
begin
  with dmData do begin
    try
      Database.ApplyUpdates([qryPersons]);
    except
      on E: EDatabaseError do
        DatabaseError( E.Message );
      else
        raise;
    end;

  end;
end;

procedure TUpdateTestFrm.cbFilterClick(Sender: TObject);
begin
  with dmData do
    qryPersons.Filtered := cbFilter.Checked;
end;

procedure TUpdateTestFrm.cbOra8BlobsClick(Sender: TObject);
begin
  Oracle8Blobs := cbOra8Blobs.Checked;
end;

end.
