(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, InspCtrl, CompInsp, ExtCtrls, DBCtrls, Db, DBTables,
  IniInsp, AppInsp, SColInsp, ShellAPI, DBInspct;

type
  TfrmMain = class(TForm)
    pgcMain: TPageControl;
    ObjectInspector: TTabSheet;
    pnlObjectInspector: TPanel;
    pnlComponentComboBox: TPanel;
    ComponentComboBox: TComponentComboBox;
    TabControl: TTabControl;
    ComponentInspector: TComponentInspector;
    pnlObjectInspectorControls: TPanel;
    PaintStyleGroup: TRadioGroup;
    SelectAllButton: TButton;
    UpdateButton: TButton;
    pnlObjectInspectorInfo: TPanel;
    ControlsPanel: TPanel;
    InstructionLabel: TLabel;
    Image: TImage;
    Edit: TEdit;
    Memo: TMemo;
    Button: TButton;
    CheckBox: TCheckBox;
    RadioButton: TRadioButton;
    ListBox: TListBox;
    memObjectInspector: TMemo;
    tshCommonInspector: TTabSheet;
    Table: TTable;
    DataSource: TDataSource;
    pnlCommonInspector: TPanel;
    dnvCommonInspector: TDBNavigator;
    CommonInspector: TCommonInspector;
    memCommonInspector: TMemo;
    pnlCommonInspectorSpace: TPanel;
    tshDBInspector: TTabSheet;
    pnlDBInspector: TPanel;
    dnvDBInspector: TDBNavigator;
    pnlDBInspectorSpace: TPanel;
    memDBInspector: TMemo;
    DBInspector: TDBInspector;
    tshIniInspector: TTabSheet;
    pnlIniInspector: TPanel;
    pnlIniInspectorSpace: TPanel;
    memIniInspector: TMemo;
    IniInspector: TIniInspector;
    lblIniInspector: TLabel;
    edtIniInspector: TEdit;
    btnIniInspector: TButton;
    opdIniInspector: TOpenDialog;
    tshAppInspector: TTabSheet;
    pnlAppInspector: TPanel;
    memAppInspector: TMemo;
    pnlAppInspectorSpace: TPanel;
    ApplicationInspector: TApplicationInspector;
    tshSysColorsInspector: TTabSheet;
    pnlSysColorsInspector: TPanel;
    pnlSysColorsInspectorSpace: TPanel;
    memSysColorsInspector: TMemo;
    SystemColorsInspector: TSystemColorsInspector;
    tshAbout: TTabSheet;
    pnlAbout: TPanel;
    lblInfo: TLabel;
    lblLink: TLabel;
    procedure TabControlChange(Sender: TObject);
    procedure PaintStyleGroupClick(Sender: TObject);
    procedure SelectAllButtonClick(Sender: TObject);
    procedure UpdateButtonClick(Sender: TObject);
    procedure ComponentComboBoxFilter(Sender: TObject;
      AComponent: TComponent; var EnableAdd: Boolean);
    procedure ComponentInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure ControlMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TableAfterOpen(DataSet: TDataSet);
    procedure TableAfterClose(DataSet: TDataSet);
    procedure TableAfterScroll(DataSet: TDataSet);
    procedure CommonInspectorGetName(Sender: TObject; TheIndex: Integer;
      var Value: String);
    procedure CommonInspectorGetReadOnly(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure CommonInspectorGetAutoApply(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure CommonInspectorGetEnableExternalEditor(Sender: TObject;
      TheIndex: Integer; var Value: Boolean);
    procedure CommonInspectorGetButtonType(Sender: TObject;
      TheIndex: Integer; var Value: TButtonType);
    function CommonInspectorCallEditor(Sender: TObject;
      TheIndex: Integer): Boolean;
    procedure CommonInspectorSetValue(Sender: TObject; TheIndex: Integer;
      const Value: String);
    procedure CommonInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure CommonInspectorGetSelectedValue(Sender: TObject;
      TheIndex: Integer; var Value: String);
    procedure CommonInspectorGetValue(Sender: TObject; TheIndex: Integer;
      var Value: String);
    procedure CommonInspectorGetNextValue(Sender: TObject;
      TheIndex: Integer; var Value: String);
    function CommonInspectorValidateChar(Sender: TObject;
      TheIndex: Integer; var Key: Char): Boolean;
    procedure CommonInspectorGetMaxLength(Sender: TObject;
      TheIndex: Integer; var Value: Integer);
    procedure TableUpdateRecord(DataSet: TDataSet; UpdateKind: TUpdateKind;
      var UpdateAction: TUpdateAction);
    procedure DBInspectorGetBlobEditorType(Sender: TObject; Field: TField;
      var BlobEditorType: TBlobEditorType);
    procedure btnIniInspectorClick(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Image;

{$R *.DFM}
{$R XP.RES}

procedure TfrmMain.TabControlChange(Sender: TObject);
begin
  ComponentInspector.Mode:=TCompInspMode(TabControl.TabIndex);
end;

procedure TfrmMain.PaintStyleGroupClick(Sender: TObject);
var
  PS: TPaintStyle;
begin
  PS:=TPaintStyle(PaintStyleGroup.ItemIndex);
  ComponentInspector.PaintStyle:=PS;
  CommonInspector.PaintStyle:=PS;
  DBInspector.PaintStyle:=PS;
  IniInspector.PaintStyle:=PS;
  ApplicationInspector.PaintStyle:=PS;
  SystemColorsInspector.PaintStyle:=PS;
end;

procedure TfrmMain.SelectAllButtonClick(Sender: TObject);
var
  i: Integer;
begin
  ComponentInspector.Lock;
  try
    if ComponentInspector.Instance=Self then ComponentInspector.Instance:=nil;
    with ControlsPanel do
      for i:=0 to Pred(ControlCount) do
        ComponentInspector.AddInstance(Controls[i]);
  finally
    ComponentInspector.Unlock;
    ComponentInspector.RefreshList;
  end;
end;

procedure TfrmMain.UpdateButtonClick(Sender: TObject);
begin
  ComponentInspector.Update;
end;

procedure TfrmMain.ComponentComboBoxFilter(Sender: TObject;
  AComponent: TComponent; var EnableAdd: Boolean);
begin
  EnableAdd:=(AComponent is TControl) and (TControl(AComponent).Parent=ControlsPanel);
end;

procedure TfrmMain.ComponentInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  with ComponentInspector do
    if Assigned(Properties[TheIndex]) and
      (Properties[TheIndex].PropType=TypeInfo(TNotifyEvent)) then
      with Strings do
      begin
        Add('TabControlChange');
        Add('ControlSelect');
        Add('SelectAllButtonClick');
        Add('UpdateButtonClick');
        Add('WebClick');
      end;
end;

procedure TfrmMain.ControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with ComponentInspector do
    if (Instance<>Sender) or (InstanceCount<>1) then Instance:=Sender as TComponent;
end;

const
  States =
  'AK'#13'AL'#13'AR'#13'AZ'#13'CA'#13'CO'#13'CT'#13'DC'#13'DE'#13'FL'#13'GA'#13+
  'HI'#13'IA'#13'ID'#13'IL'#13'IN'#13'KS'#13'KY'#13'LA'#13'MA'#13'MD'#13'ME'#13+
  'MI'#13'MN'#13'MO'#13'MS'#13'MT'#13'NC'#13'ND'#13'NE'#13'NH'#13'NJ'#13'NM'#13+
  'NV'#13'NY'#13'OH'#13'OK'#13'OR'#13'PA'#13'RI'#13'SC'#13'SD'#13'TN'#13'TX'#13+
  'UT'#13'VA'#13'VT'#13'WA'#13'WI'#13'WV'#13'WY';

procedure TfrmMain.TableAfterOpen(DataSet: TDataSet);
begin
  CommonInspector.ItemCount:=Table.FieldCount;
end;

procedure TfrmMain.TableAfterClose(DataSet: TDataSet);
begin
  CommonInspector.ItemCount:=0;
end;

procedure TfrmMain.TableAfterScroll(DataSet: TDataSet);
begin
  CommonInspector.Update;
  Table.Edit;
end;

procedure TfrmMain.CommonInspectorGetName(Sender: TObject;
  TheIndex: Integer; var Value: String);
begin
  Value:=Table.Fields[TheIndex].DisplayLabel;
end;

procedure TfrmMain.CommonInspectorGetReadOnly(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  Value:=Table.Fields[TheIndex].IsBlob;
end;

procedure TfrmMain.CommonInspectorGetAutoApply(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  Value:=False;
end;

procedure TfrmMain.CommonInspectorGetEnableExternalEditor(Sender: TObject;
  TheIndex: Integer; var Value: Boolean);
begin
  Value:=Table.Fields[TheIndex].IsBlob;
end;

procedure TfrmMain.CommonInspectorGetButtonType(Sender: TObject;
  TheIndex: Integer; var Value: TButtonType);
begin
  if Table.Fields[TheIndex].IsBlob then Value:=btDialog
  else
    if TheIndex=5 then Value:=btDropDown;
end;

function TfrmMain.CommonInspectorCallEditor(Sender: TObject;
  TheIndex: Integer): Boolean;
begin
  Result:=False;
  ImageForm.ShowModal;
  CommonInspector.Update;
end;

procedure TfrmMain.CommonInspectorSetValue(Sender: TObject;
  TheIndex: Integer; const Value: String);
begin
  if not CommonInspector.ReadOnly[TheIndex] then Table.Fields[TheIndex].AsString:=Value;
end;

procedure TfrmMain.CommonInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  if TheIndex=5 then Strings.Text:=States;
end;

procedure TfrmMain.CommonInspectorGetSelectedValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
begin
  Value:=CommonInspector.Values[TheIndex];
end;

procedure TfrmMain.CommonInspectorGetValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
begin
  if Table.Fields[TheIndex].IsBlob then Value:='(BLOB)'
  else Value:=Table.Fields[TheIndex].AsString;
end;

procedure TfrmMain.CommonInspectorGetNextValue(Sender: TObject;
  TheIndex: Integer; var Value: String);
var
  I: Integer;
begin
  if TheIndex=5 then
    with TStringList.Create do
    try
      Text:=States;
      I:=IndexOf(CommonInspector.Values[TheIndex]);
      if (I<0) or (I=Pred(Count)) then I:=0
      else Inc(I);
      Value:=Strings[I];
    finally
      Free;
    end;
end;

function TfrmMain.CommonInspectorValidateChar(Sender: TObject;
  TheIndex: Integer; var Key: Char): Boolean;
begin
  Result:=Table.Fields[TheIndex].IsValidChar(Key);
end;

procedure TfrmMain.CommonInspectorGetMaxLength(Sender: TObject;
  TheIndex: Integer; var Value: Integer);
begin
  Value:=Table.Fields[TheIndex].DataSize;
end;

procedure TfrmMain.TableUpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
  CommonInspector.Update;
end;

procedure TfrmMain.DBInspectorGetBlobEditorType(Sender: TObject;
  Field: TField; var BlobEditorType: TBlobEditorType);
begin
  if Field.FieldName='IMAGE' then BlobEditorType:=beImage;
end;

procedure TfrmMain.btnIniInspectorClick(Sender: TObject);
begin
  with opdIniInspector do
    if Execute then
    begin
      Edit.Text:=FileName;
      IniInspector.FileName:=FileName;
    end;
end;

procedure TfrmMain.lblLinkClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar(lblLink.Caption),nil,nil,SW_SHOWDEFAULT);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  SetCurrentDirectory(PChar(ExtractFilePath(Application.ExeName)));
  IniInspector.FileName:=edtIniInspector.Text;
  Table.Open;
end;

end.
