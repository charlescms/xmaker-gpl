(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, InspCtrl, ExtCtrls, DBCtrls;

type
  TMainForm = class(TForm)
    Table: TTable;
    DataSource: TDataSource;
    DBNavigator: TDBNavigator;
    Inspector: TCommonInspector;
    procedure TableAfterOpen(DataSet: TDataSet);
    procedure TableAfterClose(DataSet: TDataSet);
    procedure TableAfterScroll(DataSet: TDataSet);
    procedure InspectorGetName(Sender: TObject; TheIndex: Integer;
      var Value: String);
    procedure InspectorGetValue(Sender: TObject; TheIndex: Integer;
      var Value: String);
    procedure InspectorGetReadOnly(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure InspectorGetAutoApply(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure InspectorGetEnableExternalEditor(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure InspectorGetButtonType(Sender: TObject;
      TheIndex: Integer; var Value: TButtonType);
    function InspectorCallEditor(Sender: TObject;
      TheIndex: Integer): Boolean;
    procedure InspectorSetValue(Sender: TObject; TheIndex: Integer;
      const Value: String);
    procedure FormCreate(Sender: TObject);
    procedure InspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure InspectorGetSelectedValue(Sender: TObject;
      TheIndex: Integer; var Value: String);
    procedure InspectorGetNextValue(Sender: TObject;
      TheIndex: Integer; var Value: String);
    function InspectorValidateChar(Sender: TObject;
      TheIndex: Integer; var Key: Char): Boolean;
    procedure InspectorGetMaxLength(Sender: TObject; TheIndex: Integer;
      var Value: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses Image;

{$R *.DFM}

const
  States =
  'AK'#13'AL'#13'AR'#13'AZ'#13'CA'#13'CO'#13'CT'#13'DC'#13'DE'#13'FL'#13'GA'#13+
  'HI'#13'IA'#13'ID'#13'IL'#13'IN'#13'KS'#13'KY'#13'LA'#13'MA'#13'MD'#13'ME'#13+
  'MI'#13'MN'#13'MO'#13'MS'#13'MT'#13'NC'#13'ND'#13'NE'#13'NH'#13'NJ'#13'NM'#13+
  'NV'#13'NY'#13'OH'#13'OK'#13'OR'#13'PA'#13'RI'#13'SC'#13'SD'#13'TN'#13'TX'#13+
  'UT'#13'VA'#13'VT'#13'WA'#13'WI'#13'WV'#13'WY';

procedure TMainForm.TableAfterOpen(DataSet: TDataSet);
begin
  Inspector.ItemCount:=Table.FieldCount;
end;

procedure TMainForm.TableAfterClose(DataSet: TDataSet);
begin
  Inspector.ItemCount:=0;
end;

procedure TMainForm.TableAfterScroll(DataSet: TDataSet);
begin
  Inspector.Update;
  Table.Edit;
end;

procedure TMainForm.InspectorGetName(Sender: TObject;
  TheIndex: Integer; var Value: String);
begin
  Value:=Table.Fields[TheIndex].DisplayLabel;
end;

procedure TMainForm.InspectorGetValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
begin
  if Table.Fields[TheIndex].IsBlob then Value:='(BLOB)'
  else Value:=Table.Fields[TheIndex].AsString;
end;

procedure TMainForm.InspectorGetReadOnly(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  Value:=Table.Fields[TheIndex].IsBlob;
end;

procedure TMainForm.InspectorGetAutoApply(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  Value:=False;
end;

procedure TMainForm.InspectorGetEnableExternalEditor(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  Value:=Table.Fields[TheIndex].IsBlob;
end;

procedure TMainForm.InspectorGetButtonType(Sender: TObject;
  TheIndex: Integer; var Value: TButtonType);
begin
  if Table.Fields[TheIndex].IsBlob then Value:=btDialog
  else
    if TheIndex=5 then Value:=btDropDown;
end;

function TMainForm.InspectorCallEditor(Sender: TObject;
  TheIndex: Integer): Boolean;
begin
  Result:=False;
  ImageForm.ShowModal;
  Inspector.Update;
end;

procedure TMainForm.InspectorSetValue(Sender: TObject;
  TheIndex: Integer; const Value: String);
begin
  if not Inspector.ReadOnly[TheIndex] then Table.Fields[TheIndex].AsString:=Value;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetCurrentDirectory(PChar(ExtractFilePath(Application.ExeName)));
  Table.Open;
end;

procedure TMainForm.InspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  if TheIndex=5 then Strings.Text:=States;
end;

procedure TMainForm.InspectorGetSelectedValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
begin
  Value:=Inspector.Values[TheIndex];
end;

procedure TMainForm.InspectorGetNextValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
var
  I: Integer;
begin
  if TheIndex=5 then
    with TStringList.Create do
    try
      Text:=States;
      I:=IndexOf(Inspector.Values[TheIndex]);
      if (I<0) or (I=Pred(Count)) then I:=0
      else Inc(I);
      Value:=Strings[I];
    finally
      Free;
    end;
end;

function TMainForm.InspectorValidateChar(Sender: TObject;
  TheIndex: Integer; var Key: Char): Boolean;
begin
  Result:=Table.Fields[TheIndex].IsValidChar(Key);
end;

procedure TMainForm.InspectorGetMaxLength(Sender: TObject;
  TheIndex: Integer; var Value: Integer);
begin
  Value:=Table.Fields[TheIndex].DataSize;
end;

end.
