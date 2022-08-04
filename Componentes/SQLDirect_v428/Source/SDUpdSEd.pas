
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       SQLUpdate Editor Dialog	   			}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}

unit SDUpdSEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Menus, Db,
  SDConsts, SDCommon, SDEngine;

type
  TSDUpdateSQLEditForm = class(TForm)
    pcUpdateSQL: TPageControl;
    tsOptions: TTabSheet;
    tsSQL: TTabSheet;
    pnlButton: TPanel;
    btOk: TButton;
    btCancel: TButton;
    lblSQLText: TLabel;
    meSQLText: TMemo;
    gbxGenSQL: TGroupBox;
    lblTableName: TLabel;
    cbTableName: TComboBox;
    lblKeyFields: TLabel;
    lbKeyFields: TListBox;
    lblUpdateFields: TLabel;
    lbUpdateFields: TListBox;
    btDataSetDefaults: TButton;
    btGenerateSQL: TButton;
    pmFields: TPopupMenu;
    miSelectAll: TMenuItem;
    miClearAll: TMenuItem;
    rgrStatementType: TRadioGroup;
    btGetTableFields: TButton;
    cbQuotedFields: TCheckBox;
    btSelectPrimKeys: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbTableNameChange(Sender: TObject);
    procedure TableNameChanged(Sender: TObject);
    procedure GetTableFieldsClick(Sender: TObject);
    procedure DataSetDefaultsClick(Sender: TObject);
    procedure GenerateSQLClick(Sender: TObject);
    procedure SelectAllClick(Sender: TObject);
    procedure ClearAllClick(Sender: TObject);
    procedure StatementTypeClick(Sender: TObject);
    procedure SQLTextExit(Sender: TObject);
    procedure btSelectPrimKeysClick(Sender: TObject);
  private
    FRefreshSQL:TStrings;
    FModifySQL: TStrings;
    FInsertSQL: TStrings;
    FDeleteSQL: TStrings;
    FUpdateSQL: TSDUpdateSQL;
    FFieldInfo,
    FTableInfo: TStrings;
    function FindFieldAlias(const TableName, FieldName: string): string;
    procedure GenerateModifySQL;
    procedure GenerateInsertSQL;
    procedure GenerateDeleteSQL;
    procedure GenerateRefreshSQL;
    procedure LoadDefaultOptions;
    procedure LoadStatements;
    procedure SelectAllFields;
    procedure SetSelectedAllItems(lb: TListBox; State: Boolean);
  public
    procedure InitProperties;
    procedure SaveStatements;
    function QuoteName(const AIdentName: string): string;
    property UpdateSQL: TSDUpdateSQL read FUpdateSQL write FUpdateSQL;
  end;

var
  SDUpdateSQLEditForm: TSDUpdateSQLEditForm;

function EditUpdateSQL(AUpdateSQL: TSDUpdateSQL): Boolean;

implementation

{$R *.DFM}

function EditUpdateSQL(AUpdateSQL: TSDUpdateSQL): Boolean;
var
  Dlg: TSDUpdateSQLEditForm;
  sCaption: string;
begin
  Result := False;
  sCaption := '';
  Dlg := TSDUpdateSQLEditForm.Create(Application);
  try
    if (AUpdateSQL.Owner is TForm) then
      sCaption := (AUpdateSQL.Owner as TForm).Name + '.';

    sCaption := sCaption + AUpdateSQL.Name;
    if Assigned( AUpdateSQL.DataSet ) then
      sCaption := Format('%s (%s)', [sCaption, AUpdateSQL.DataSet.Name])
    else
      sCaption := Format('%s (%s)', [sCaption, SNoDataSet]);

    Dlg.Caption := sCaption;
    Dlg.UpdateSQL := AUpdateSQL;
    Dlg.InitProperties;
    if Dlg.ShowModal = mrOk then begin
      Dlg.SaveStatements;

      Result := True;
    end;
  finally
    Dlg.Free;
  end;
end;

{ TSDUpdateSQLEditForm }
procedure TSDUpdateSQLEditForm.InitProperties;
begin
  LoadDefaultOptions;
  SelectAllFields;

  LoadStatements;
  DataSetDefaultsClick( nil );  // at first load dataset fields only
  StatementTypeClick( nil );
end;

{ At first show dataset fields and disable "DataSet Defaults" button }
procedure TSDUpdateSQLEditForm.LoadDefaultOptions;
var
  SaveCursor: TCursor;
  i: Integer;
  q: TSDQuery;
begin
  if FUpdateSQL.DataSet = nil then
    Exit;
  if not(FUpdateSQL.DataSet is TSDQuery) then
    Exit;

  q := TSDQuery(FUpdateSQL.DataSet);
  SaveCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;

    FFieldInfo.Clear;
    FTableInfo.Clear;

    q.GetFieldInfoFromSQL( q.Text, FFieldInfo, FTableInfo );

    cbTableName.Clear;
    lbKeyFields.Clear;
    lbUpdateFields.Clear;

    for i:=0 to FTableInfo.Count-1 do
      if Length( FTableInfo.Names[i] ) > 0 then
        cbTableName.Items.Add( FTableInfo.Values[FTableInfo.Names[i]] );

    if cbTableName.Items.Count > 0 then
      cbTableName.ItemIndex := 0;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TSDUpdateSQLEditForm.LoadStatements;
begin
  FRefreshSQL.Assign( FUpdateSQL.RefreshSQL );
  FModifySQL.Assign( FUpdateSQL.ModifySQL );
  FInsertSQL.Assign( FUpdateSQL.InsertSQL );
  FDeleteSQL.Assign( FUpdateSQL.DeleteSQL );
end;

procedure TSDUpdateSQLEditForm.SaveStatements;
begin
  FUpdateSQL.RefreshSQL.Assign( FRefreshSQL );
  FUpdateSQL.ModifySQL.Assign( FModifySQL );
  FUpdateSQL.InsertSQL.Assign( FInsertSQL );
  FUpdateSQL.DeleteSQL.Assign( FDeleteSQL );
end;

procedure TSDUpdateSQLEditForm.SelectAllFields;
begin
  pmFields.PopupComponent := lbKeyFields;
  SelectAllClick( nil );
  pmFields.PopupComponent := lbUpdateFields;
  SelectAllClick( nil );
end;

procedure TSDUpdateSQLEditForm.SetSelectedAllItems(lb: TListBox; State: Boolean);
var
  i: Integer;
begin
  for i:=0 to lb.Items.Count-1 do
    lb.Selected[i] := State;
end;

{
FFieldInfo.Strings[i] = "FieldAlias=[Owner.]Table.FieldName"
FTableInfo.Strings[i] = "Alias=TableName"

!!! same FieldName could be located in different tables with different aliases !!!

}
function TSDUpdateSQLEditForm.FindFieldAlias(const TableName, FieldName: string): string;
var
  i, j: Integer;
  s, sField, sTable: string;
begin
  Result := FieldName;

  for i:=0 to FFieldInfo.Count-1 do begin
    s := FFieldInfo.Values[FFieldInfo.Names[i]];
    j := Length(s);
    while j > 0 do begin
      if (s[j] = '.') and (j < Length(s)) then begin
      	// extract physical field and table name
        sField := Copy( s, j+1, Length(s)-j );
        sTable := Copy( s, 1, j-1 );

        if (sField = FieldName) and (sTable = TableName) then begin
		// return field alias (for parameter name)        
          Result := FFieldInfo.Names[i];
          Exit;
        end;
        Break;
      end;
      Dec( j );
    end;
  end;
end;

procedure TSDUpdateSQLEditForm.GenerateModifySQL;
const
  UpdateClause	= 'update ';
  SetClause	= 'set';
  WhereClause	= 'where';
  AndOp		= ' and';
  SetIndent	= '  ';
var
  sTableName, sStr, sField: string;
  i: Integer;
begin
  FModifySQL.Clear;

  sTableName := cbTableName.Text;
  FModifySQL.Add( UpdateClause + sTableName );
  FModifySQL.Add( SetClause );
	// add SET clause (update fields)
  with lbUpdateFields do
    for i:=0 to Items.Count-1 do
      if Selected[i] then begin
        sField := Items[i];
        sStr := Format( '%s%s = :%s',
        	[SetIndent, QuoteName(sField), QuoteName(FindFieldAlias(sTableName, sField))] );

        if FModifySQL.Strings[FModifySQL.Count-1] <> SetClause then
          FModifySQL.Strings[FModifySQL.Count-1] := FModifySQL.Strings[FModifySQL.Count-1] + ',';
        FModifySQL.Add( sStr );
      end;
	// add WHERE clause (key fields)
  FModifySQL.Add( WhereClause );
  with lbKeyFields do
    for i:=0 to Items.Count-1 do
      if Selected[i] then begin
        sField := lbKeyFields.Items[i];
        sStr := Format( '%s%s = :%s',
        	[SetIndent, QuoteName(sField), QuoteName('OLD_' + FindFieldAlias(sTableName, sField))] );

        if FModifySQL.Strings[FModifySQL.Count-1] <> WhereClause then
          FModifySQL.Strings[FModifySQL.Count-1] := FModifySQL.Strings[FModifySQL.Count-1] + AndOp;
        FModifySQL.Add( sStr );
      end;

end;

procedure TSDUpdateSQLEditForm.GenerateRefreshSQL;
const
  SelectClause	= 'select ';
  FromClause	= 'from ';
  WhereClause	= 'where';
  AndOp		= ' and';
  SetIndent	= '  ';
var
  sTableName, sStr, sField, sFields: string;
  i: Integer;
begin
  FRefreshSQL.Clear;
  sFields := '';

  sTableName := cbTableName.Text;
	// add fields in SELECT clause (refresh fields)
  with lbUpdateFields do
    for i:=0 to Items.Count-1 do
      if Selected[i] then begin
        sField := Items[i];
        if sFields <> '' then sFields := sFields + ', ';
        sFields := sFields + QuoteName(sField);
        sStr := FindFieldAlias(sTableName, sField);
        	// add a field alias, when it is necessary
        if sStr <> sField then
          sFields := sFields + ' as ' + QuoteName(sStr);
      end;
  FRefreshSQL.Add( SelectClause + sFields + #$0D#$0A + FromClause + sTableName );
	// add WHERE clause (key fields)
  FRefreshSQL.Add( WhereClause );
  with lbKeyFields do
    for i:=0 to Items.Count-1 do
      if Selected[i] then begin
        sField := lbKeyFields.Items[i];
        sStr := Format( '%s%s = :%s',
        	[SetIndent, QuoteName(sField), QuoteName('OLD_' + FindFieldAlias(sTableName, sField))] );

        if FRefreshSQL.Strings[FRefreshSQL.Count-1] <> WhereClause then
          FRefreshSQL.Strings[FRefreshSQL.Count-1] := FRefreshSQL.Strings[FRefreshSQL.Count-1] + AndOp;
        FRefreshSQL.Add( sStr );
      end;
end;

procedure TSDUpdateSQLEditForm.GenerateInsertSQL;
const
  InsertClause	= 'insert into ';
var
  sFields, sParams, sField, sParam, sTableName: string;
  i: Integer;
begin
  FInsertSQL.Clear;

  sTableName := cbTableName.Text;
  FInsertSQL.Add( InsertClause + sTableName );
	// collect fields and parameters (update fields)
  with lbUpdateFields do
    for i:=0 to Items.Count-1 do
      if Selected[i] then begin
        sField := Items[i];
        sParam := FindFieldAlias( sTableName, sField );

        if sFields <> '' then
          sFields := sFields + ', ';
        sFields := sFields + QuoteName(sField);

        if sParams <> '' then
          sParams := sParams + ', ';
        sParams := sParams + ':' + QuoteName(sParam);
      end;
  FInsertSQL.Add( '  (' + sFields + ')' );
  FInsertSQL.Add( 'values' );
  FInsertSQL.Add( '  (' + sParams + ')' );
end;

procedure TSDUpdateSQLEditForm.GenerateDeleteSQL;
const
  DeleteClause	= 'delete from ';
  WhereClause	= 'where';
  AndOp		= ' and';
  SetIndent	= '  ';
var
  sField, sStr, sTableName: string;
  i: Integer;
begin
  FDeleteSQL.Clear;
	// it is possible to remove a table alias, if it's present. For example, MSSQL do not support a table alias for DELETE ???
  sTableName := cbTableName.Text;
  FDeleteSQL.Add( DeleteClause + sTableName );

	// add WHERE clause (key fields)
  FDeleteSQL.Add( WhereClause );
  with lbKeyFields do
    for i:=0 to Items.Count-1 do
      if Selected[i] then begin
        sField := lbKeyFields.Items[i];
        sStr := Format( '%s%s = :%s',
        	[SetIndent, QuoteName(sField), QuoteName('OLD_' + FindFieldAlias(sTableName, sField))] );

        if FDeleteSQL.Strings[FDeleteSQL.Count-1] <> WhereClause then
          FDeleteSQL.Strings[FDeleteSQL.Count-1] := FDeleteSQL.Strings[FDeleteSQL.Count-1] + AndOp;
        FDeleteSQL.Add( sStr );
      end;
end;

procedure TSDUpdateSQLEditForm.FormCreate(Sender: TObject);
begin
  FRefreshSQL	:= TStringList.Create;
  FModifySQL	:= TStringList.Create;
  FInsertSQL	:= TStringList.Create;
  FDeleteSQL	:= TStringList.Create;

  FFieldInfo	:= TStringList.Create;
  FTableInfo	:= TStringList.Create;

  FUpdateSQL	:= nil;

  pcUpdateSQL.ActivePage := tsOptions;
end;

procedure TSDUpdateSQLEditForm.FormDestroy(Sender: TObject);
begin
  FFieldInfo.Free;
  FTableInfo.Free;

  FRefreshSQL.Free;  
  FModifySQL.Free;
  FInsertSQL.Free;
  FDeleteSQL.Free;
end;

procedure TSDUpdateSQLEditForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult <> mrOk then begin
    CanClose := True;
    Exit;
  end;
  CanClose := False;
  if Length(Trim( FModifySQL.Text )) > 0 then
    CanClose := True
  else
    if MessageDlg( SSQLNotGenerated, mtConfirmation, [mbYes, mbNo, mbCancel], 0 ) = mrYes then
      CanClose := True;
end;

procedure TSDUpdateSQLEditForm.cbTableNameChange(Sender: TObject);
var
  EmptyTableName: Boolean;
begin
  EmptyTableName := Length(Trim( cbTableName.Text )) = 0;

  btGetTableFields.Enabled	:= not EmptyTableName;
  btSelectPrimKeys.Enabled      := not EmptyTableName;
  btGenerateSQL.Enabled		:= not EmptyTableName;
end;

procedure TSDUpdateSQLEditForm.TableNameChanged(Sender: TObject);
begin
  cbTableNameChange(Sender);

  if btGetTableFields.Enabled then
    GetTableFieldsClick( Self );
end;

procedure TSDUpdateSQLEditForm.GetTableFieldsClick(Sender: TObject);
  	{ extract only a table name (without owner) }
  function RemoveOwnerName(const ATableName: string): string;
  var
    i: Integer;
  begin
    Result := '';
    for i:=Length(ATableName) downto 1 do begin
      if (ATableName[i] = '.') and (i < Length(ATableName)) then begin
        Result := Copy( ATableName, i+1, Length(ATableName)-i );
        Break;
      end;
    end;
        // if the table name does not contain an owner name
    if Result = '' then
      Result := ATableName;
  end;

var
  List: TStrings;
  i, CurLen, MaxLen1, MaxLen2: Integer;
  sTableName, s: string;
begin
  ASSERT( FUpdateSQL.DataSet <> nil );
	// sTableName can contain a name of the Owner
  sTableName := cbTableName.Text;
  	// extract a table name without quote characters
  i := 1;
  while i <= Length(sTableName) do begin
    if AnsiChar(sTableName[i]) in ['"', ''''] then
      Delete( sTableName, i, 1 );
    Inc( i );
  end;

  List := TStringList.Create;
  try
  	// first, check a table with owner name to exclude duplicated fields in case some tables with one name
    FUpdateSQL.DataSet.DBSession.GetFieldNames(
    		FUpdateSQL.DataSet.DatabaseName,
                sTableName, List );
    	// if nothing is returned, check the table without owner name
    if List.Count = 0 then begin
      s := RemoveOwnerName(sTableName);
      if s <> sTableName then
        FUpdateSQL.DataSet.DBSession.GetFieldNames(
    		FUpdateSQL.DataSet.DatabaseName,
                s, List );
    end;
    if List.Count > 0 then begin
      lbKeyFields.Items.Clear;
      lbUpdateFields.Items.Clear;

      MaxLen1 := 0; MaxLen2 := 0;
      for i:=0 to List.Count-1 do
        if Length( List.Strings[i] ) > 0 then begin
          lbKeyFields.Items.Add( List.Strings[i] );
          lbUpdateFields.Items.Add( List.Strings[i] );

          CurLen := lbKeyFields.Canvas.TextWidth(List.Strings[i] + 'A');
          if CurLen > MaxLen1 then MaxLen1 := CurLen;
          CurLen := lbUpdateFields.Canvas.TextWidth(List.Strings[i] + 'A');
          if CurLen > MaxLen2 then MaxLen2 := CurLen;
        end;
      SendMessage(lbKeyFields.Handle, LB_SETHORIZONTALEXTENT, MaxLen1, 0);
      SendMessage(lbUpdateFields.Handle, LB_SETHORIZONTALEXTENT, MaxLen2, 0);
    end else
      MessageDlg( Format(SSQLDataSetOpen, [sTableName]), mtError, [mbOk], 0 );

    SelectAllFields;
    btDataSetDefaults.Enabled := True;
  finally
    List.Free;
  end;
end;

procedure TSDUpdateSQLEditForm.DataSetDefaultsClick(Sender: TObject);
var
  i: Integer;
begin
  lbKeyFields.Clear;
  lbUpdateFields.Clear;

  for i:=0 to FFieldInfo.Count-1 do
    if Length( FFieldInfo.Names[i] ) > 0 then begin
      lbKeyFields.Items.Add( FFieldInfo.Names[i] );
      lbUpdateFields.Items.Add( FFieldInfo.Names[i] );
    end;

  SelectAllFields;
  btDataSetDefaults.Enabled := False;  
end;

procedure TSDUpdateSQLEditForm.GenerateSQLClick(Sender: TObject);
begin
  if (lbKeyFields.SelCount = 0) or (lbUpdateFields.SelCount = 0) then begin
    MessageDlg( SSQLGenSelect, mtError, [mbOk], 0 );
    Exit;
  end;

  GenerateModifySQL;
  GenerateInsertSQL;
  GenerateDeleteSQL;
  GenerateRefreshSQL;  

  StatementTypeClick( Self );  
end;


procedure TSDUpdateSQLEditForm.SelectAllClick(Sender: TObject);
begin
  if pmFields.PopupComponent = lbKeyFields then
    SetSelectedAllItems( lbKeyFields, True )
  else if pmFields.PopupComponent = lbUpdateFields then
    SetSelectedAllItems( lbUpdateFields, True )
end;

procedure TSDUpdateSQLEditForm.ClearAllClick(Sender: TObject);
begin
  if pmFields.PopupComponent = lbKeyFields then
    SetSelectedAllItems( lbKeyFields, False )
  else if pmFields.PopupComponent = lbUpdateFields then
    SetSelectedAllItems( lbUpdateFields, False )
end;

procedure TSDUpdateSQLEditForm.StatementTypeClick(Sender: TObject);
begin
  case rgrStatementType.ItemIndex of
    0: meSQLText.Lines.Assign( FRefreshSQL );
    1: meSQLText.Lines.Assign( FModifySQL );
    2: meSQLText.Lines.Assign( FInsertSQL );
    3: meSQLText.Lines.Assign( FDeleteSQL );
  end;
end;

procedure TSDUpdateSQLEditForm.SQLTextExit(Sender: TObject);
begin
  case rgrStatementType.ItemIndex of
    0: FRefreshSQL.Assign( meSQLText.Lines );
    1: FModifySQL.Assign( meSQLText.Lines );
    2: FInsertSQL.Assign( meSQLText.Lines );
    3: FDeleteSQL.Assign( meSQLText.Lines );
  end;
end;

function TSDUpdateSQLEditForm.QuoteName(const AIdentName: string): string;
begin
  Result := AIdentName;
  if cbQuotedFields.Checked then
    Result := '"' + Result + '"';
end;

procedure TSDUpdateSQLEditForm.btSelectPrimKeysClick(Sender: TObject);
var
  ids: TDataSet;
  db: TSDDatabase;
  PrimFields, UIdxFields: TStrings;
  i, IdxType: Integer;
  sFld, sUniqueIndex, sCurIdxName: string;
begin
  db := FUpdateSQL.DataSet.DBSession.FindDatabase( FUpdateSQL.DataSet.DatabaseName );
  ids := db.GetSchemaInfo(stIndexes, cbTableName.Text);
  if not Assigned(ids) then
    Exit;
  sUniqueIndex := '';
  PrimFields   := TStringList.Create;
  UIdxFields   := TStringList.Create;
  try
    while not ids.EOF do begin
      if not ids.FieldByName(IDX_TYPE_FIELD).IsNull then begin
        IdxType := ids.FieldByName(IDX_TYPE_FIELD).AsInteger;
        if (IdxType and PrimaryIndexType) <> 0 then begin
          sFld := ids.FieldByName(IDX_COL_NAME_FIELD).AsString;
          PrimFields.Add(sFld);
        end;
        if (IdxType and UniqueIndexType) <> 0 then begin
          sCurIdxName := ids.FieldByName(IDX_NAME_FIELD).AsString;
                // mark the first unique index
          if sUniqueIndex = '' then
            sUniqueIndex := sCurIdxName;
          if sUniqueIndex = sCurIdxName then
            UIdxFields.Add( ids.FieldByName(IDX_COL_NAME_FIELD).AsString );
        end;
      end;
      ids.Next;
    end;
    for i:=0 to lbKeyFields.Items.Count-1 do
      lbKeyFields.Selected[i] := False;
    if PrimFields.Count > 0 then
      for i:=0 to lbKeyFields.Items.Count-1 do
        lbKeyFields.Selected[i] := PrimFields.IndexOf(lbKeyFields.Items[i]) >= 0
    else if UIdxFields.Count > 0 then
      for i:=0 to lbKeyFields.Items.Count-1 do
        lbKeyFields.Selected[i] := UIdxFields.IndexOf(lbKeyFields.Items[i]) >= 0;

  finally
    UIdxFields.Free;
    PrimFields.Free;
    ids.Free;
  end;
end;


end.
