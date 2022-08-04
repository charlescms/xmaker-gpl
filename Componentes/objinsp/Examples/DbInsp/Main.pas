(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, InspCtrl, ExtCtrls, DBCtrls, DBInspct, Grids,
  DBGrids, Mask;

type
  TMainForm = class(TForm)
    Table: TTable;
    DataSource: TDataSource;
    DBNavigator: TDBNavigator;
    DBInspector: TDBInspector;
    DBGrid1: TDBGrid;
    procedure DBInspectorGetBlobEditorType(Sender: TObject; Field: TField;
      var BlobEditorType: TBlobEditorType);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.DBInspectorGetBlobEditorType(Sender: TObject;
  Field: TField; var BlobEditorType: TBlobEditorType);
begin
  if Field.FieldName='IMAGE' then BlobEditorType:=beImage;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Table.Active:=True;
end;

end.
