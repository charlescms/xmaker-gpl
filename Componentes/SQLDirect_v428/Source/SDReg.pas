
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       SQLDirect Components Registration		}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDReg {$IFDEF SD_CLR}platform{$ENDIF};

interface

uses
  Windows, Messages, SysUtils, Classes,
{$IFDEF SD_VCL6}
 {$IFDEF SD_CLR}
  WinUtils, 
  Borland.Vcl.Design.DesignIntf, Borland.Vcl.Design.DesignEditors, Borland.Vcl.Design.TreeIntf,
 {$ELSE}
  DesignIntf, DesignEditors, TreeIntf, {$IFNDEF SD_VCL9} DiagramSupport, {$ENDIF}
 {$ENDIF}
{$ELSE}
  DsgnIntf,
{$ENDIF}
{$IFDEF SD_VCL5}
 {$IFDEF SD_CLR}
  Borland.Vcl.Design.FldProp, Borland.Vcl.Design.DsnDBCst, Borland.Vcl.Design.FldLinks,
 {$ELSE}
  DBReg, DsnDB, FldLinks,
 {$ENDIF}
 {$IFNDEF SD_VCL6}
  ParentageSupport, DataModelSupport,
 {$ENDIF}
{$ENDIF}
{$IFDEF SD_CLR}
  Borland.Vcl.Design.DSDesign,
{$ELSE}
  DSDesign,
{$ENDIF}
  Dialogs, TypInfo,
  StdCtrls, Controls, Graphics, Forms,
  Db, SDEngine;

type

  { TSDStringProperty }
  TSDStringProperty = class(TStringProperty)
    procedure GetValueList(List: TStrings); virtual; abstract;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


  { TSDSessionNameProperty }
  TSDSessionNameProperty = class(TSDStringProperty)
    procedure GetValueList(List: TStrings); override;
  end;

  { TSDDatabaseNameProperty }
  TSDDatabaseNameProperty = class(TSDStringProperty)
    procedure GetValueList(List: TStrings); override;
  end;

  { TSDStoredProcNameProperty }
  TSDStoredProcNameProperty = class(TSDStringProperty)
    procedure GetValueList(List: TStrings); override;
  end;


  { TSDParamsProperty }
  TSDParamsProperty = class(TPropertyEditor)
  public
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { TSDQueryParamsProperty }
  TSDQueryParamsProperty = class(TSDParamsProperty)
    procedure Edit; override;
  end;

  { TSDStoredProcParamsProperty }
  TSDStoredProcParamsProperty = class(TSDParamsProperty)
    procedure Edit; override;
  end;

{ TSDTableNameProperty }
  TSDTableNameProperty = class(TSDStringProperty)
  public
    function AutoFill: Boolean; {$IFDEF SD_VCL4} override; {$ENDIF}
    procedure GetValueList(AList: TStrings); override;
  end;


{ TSDDefaultEditor }

  TSDDefaultEditor = class(TComponentEditor)
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{$IFDEF SD_VCL5}

{ TSDTableFieldLinkProperty }

  TSDTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    FTable: TSDTable;
  protected
    procedure GetFieldNamesForIndex(List: TStrings); override;
    function GetIndexBased: Boolean; override;
    function GetIndexDefs: TIndexDefs; override;
    function GetIndexFieldNames: string; override;
    function GetIndexName: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetIndexName(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    property IndexBased: Boolean read GetIndexBased;
    property IndexDefs: TIndexDefs read GetIndexDefs;
    property IndexFieldNames: string read GetIndexFieldNames write SetIndexFieldNames;
    property IndexName: string read GetIndexName write SetIndexName;
    property MasterFields: string read GetMasterFields write SetMasterFields;

    procedure Edit; override;
  end;

{$IFDEF SD_VCL6}
  TSDComponentSprig 	= TComponentSprig;
  TSDSprigAtRoot	= TComponentSprig;
{$ELSE}
  TSDComponentSprig 	= TSprig;
  TSDSprigAtRoot	= TSprigAtRoot;
{$ENDIF}
(*
  TSDSessionSprig = class(TSDSprigAtRoot)
  public
    function Name: string; override;
    function Caption: string; override;
    function AnyProblems: Boolean; override;
  end;

  TSDDatabaseSprig = class(TSDComponentSprig)
  public
    function Name: string; override;
    function Caption: string; override;
    function AnyProblems: Boolean; override;
{    procedure FigureParent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;}
  end;

  TSDUpdateSQLSprig = class(TSDSprigAtRoot)
  public
    function AnyProblems: Boolean; override;
  end;

  TSDDataSetSprig = class(TDataSetSprig)
  public
    function AnyProblems: Boolean; override;
{    procedure FigureParent; override;
    procedure Reparent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;}
  end;

  TSDTableSprig = class(TSDDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TSDQuerySprig = class(TSDDataSetSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  TSDStoredProcSprig = class(TSDDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TSDDataSetIsland = class(TDataSetIsland)
  end;

  TSDQueryIsland = class(TSDDataSetIsland)
  end;

  TSDTableIsland = class(TSDDataSetIsland)
  end;

  TSDQueryMasterDetailBridge = class(TMasterDetailBridge)
  public
    class function RemoveMasterFieldsAsWell: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
  end;

  TSDTableMasterDetailBridge = class(TMasterDetailBridge)
  public
    function CanEdit: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
    function Edit: Boolean; override;
  end;
 *)
{$ENDIF}

{ TSDDataSetEditor }

  TSDDataSetEditor = class(
{$IFDEF SD_VCL5}      TDataSetEditor
{$ELSE}               TComponentEditor
{$ENDIF} )
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TSDQueryEditor }

  TSDQueryEditor = class(TSDDataSetEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TSDStoredProcEditor }

  TSDStoredProcEditor = class(TSDDataSetEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TSDUpdateSQLEditor }

  TSDUpdateSQLEditor = class(TSDDefaultEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TSDScriptEditor }

  TSDScriptEditor = class(TSDDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

uses
  SDConsts, SDCommon, SDCsbSrv,
{$IFDEF SD_VCL4}
 {$IFDEF SD_CLR}
  Borland.Vcl.Design.ColnEdit,
 {$ELSE}
  ColnEdit,
 {$ENDIF}
{$ELSE}
  SDQPDlg, SDSpPDlg,
{$ENDIF}
{$IFDEF EVAL}SDRemind,{$ENDIF}
  SDAbout, SDUpdSEd;

{$IFDEF SD_CLR}
  {$R ImagesDotNet\TSDDatabase.bmp}
  {$R ImagesDotNet\TSDMacroQuery.bmp}
  {$R ImagesDotNet\TSDQuery.bmp}
  {$R ImagesDotNet\TSDScript.bmp}
  {$R ImagesDotNet\TSDSession.bmp}
  {$R ImagesDotNet\TSDStoredProc.bmp}
  {$R ImagesDotNet\TSDTable.bmp}
  {$R ImagesDotNet\TSDUpdateSQL.bmp}
  {$R ImagesDotNet\TSDSQLBaseServer.bmp} 
{$ELSE}
  {$R 'SDReg.dcr'}
{$ENDIF}

type
{$IFDEF SD_VCL6}
  TSDHelperDesigner  	= IDesigner;
{$ELSE}
 {$IFDEF SD_VCL5}
  TSDHelperDesigner  	= IFormDesigner;
 {$ELSE}
  {$IFDEF SD_VCL4}
  TSDHelperDesigner  	= IDesigner;
  {$ELSE}
  TSDHelperDesigner  	= TDesigner;
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

function GetAboutVerbName: string;
var
{$IFNDEF SD_CLR}
  sFileName,
{$ENDIF}
  sProductName, sProductVers: string;
begin
  sProductName := SSQLDirectProductName;
{$IFDEF SD_CLR}
        // in Delphi 8 IDE GetModuleFileName returns an empty string and GetLastError returns 0
  sProductVers := SSQLDirectVersion;        
{$ELSE}
  sProductVers := '';

  sFileName := GetModuleFileNameStr(HInstance);

  ReadFileVersInfo(sFileName, sProductName, sProductVers);
{$ENDIF}
  Result := sProductName + ' ' + sProductVers;
end;

function ShowQueryParamsEditor(Designer: TSDHelperDesigner; Query: TSDQuery): Boolean;
{$IFNDEF SD_VCL4}
var
  List: TSDHelperParams;
{$ENDIF}
begin
  Result := False;
{$IFDEF SD_VCL4}
  {$IFDEF SD_CLR}Borland.Vcl.Design.{$ENDIF}ColnEdit.ShowCollectionEditorClass(Designer, TCollectionEditor, Query, Query.Params, 'Params', [] );
{$ELSE}
  List := TSDHelperParams.Create;
  try
    List.Assign(Query.Params);
    if EditQueryParams(Query, List) and not(List.IsEqual(Query.Params)) then begin
      Query.Close;
      Query.Params := List;
      Result := True
    end;
  finally
    List.Free;
  end;
{$ENDIF}
end;

function ShowStoredProcParamsEditor(Designer: TSDHelperDesigner; StoredProc: TSDStoredProc): Boolean;
var
{$IFDEF SD_VCL4}
  db: TSDDatabase;
{$ELSE}
  List: TSDHelperParams;
{$ENDIF}
begin
  Result := False;
{$IFDEF SD_VCL4}
  if (StoredProc.ParamCount = 0) and (not StoredProc.Prepared) then
    StoredProc.Prepare;
  db := StoredProc.Database;    // it is assigned, when Prepared = True
  if not Assigned(db) and (Trim(StoredProc.DatabaseName) <> '') then
    db := Sessions.List[StoredProc.SessionName].FindDatabase(StoredProc.DatabaseName);
  if Assigned(db) and db.Connected and StoredProc.DescriptionsAvailable then
    {$IFDEF SD_CLR}Borland.Vcl.Design.{$ENDIF}ColnEdit.ShowCollectionEditorClass(Designer, TCollectionEditor, StoredProc, StoredProc.Params, 'Params', [] )
  else
    {$IFDEF SD_CLR}Borland.Vcl.Design.{$ENDIF}ColnEdit.ShowCollectionEditorClass(Designer, TCollectionEditor, StoredProc, StoredProc.Params, 'Params', [coAdd, coDelete] );

  if StoredProc.Prepared then
    StoredProc.UnPrepare;
{$ELSE}
  List := TSDHelperParams.Create;
  try
    if (StoredProc.ParamCount > 0) or StoredProc.Prepared or
       (not StoredProc.DescriptionsAvailable)
    then
      List.Assign(StoredProc.Params)
    else begin
      StoredProc.Prepare;
      try
        List.Assign(StoredProc.Params);
      finally
        StoredProc.UnPrepare;
      end;
    end;
    if EditStoredProcParams(StoredProc, List) and
       not(List.IsEqual(StoredProc.Params))
    then begin
      StoredProc.Close;
      StoredProc.Params := List;
      Result := True;
    end;
  finally
    List.Free;
  end;
{$ENDIF}
end;

function ShowUpdateSQLDesigner(Designer: TSDHelperDesigner; AUpdateSQL: TSDUpdateSQL): Boolean;
begin
  Result := False;
  if EditUpdateSQL(AUpdateSQL) then begin
    if Assigned(Designer) then
      Designer.Modified;
    Result := True;
  end;
end;

function IsDatabaseOpen(DataSet: TSDDataSet): Boolean;
var
  Session: TSDSession;
  DB: TSDDatabase;
begin
  Result := False;
  with DataSet do begin
    Session := Sessions.FindSession(SessionName);
    if Session <> nil then begin
      DB := Session.FindDatabase(DatabaseName);
      Result := (DB <> nil) and DB.Connected;
    end;
  end;
end;


{ TSDDefaultEditor }
procedure TSDDefaultEditor.Edit;
begin
  ExecuteVerb(0);
end;

procedure TSDDefaultEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowAboutBox;
  end;
end;

function TSDDefaultEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := GetAboutVerbName;
  end;
end;

function TSDDefaultEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TSDDataSetEditor }
procedure TSDDataSetEditor.Edit;
begin
  ExecuteVerb(2);
end;

procedure TSDDataSetEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowAboutBox;
    2:
{$IFDEF SD_VCL5}
       {$IFDEF SD_CLR}Borland.Vcl.Design.{$ENDIF}DSDesign.ShowFieldsEditor(Designer, TSDDataSet(Component), GetDSDesignerClass); // or inherited ExecuteVerb(Index)
{$ELSE}
       DSDesign.ShowDatasetDesigner(Designer, TSDDataSet(Component));
{$ENDIF}
  end;
end;

function TSDDataSetEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := GetAboutVerbName;
    1: Result := '-';
    2: Result := SDatasetDesigner; // // or Result := inherited GetVerb(Index)
  end;
end;

function TSDDataSetEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;


{ TSDQueryEditor }
procedure TSDQueryEditor.ExecuteVerb(Index: Integer);
var
  q: TSDQuery;
begin
  q := Component as TSDQuery;
  case Index of
    0,
    2: inherited ExecuteVerb(Index);
    3: if ShowQueryParamsEditor(Designer, q) and Assigned(Designer) then
         Designer.Modified;
  end;
end;

function TSDQueryEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0,
    1,
    2: Result := inherited GetVerb(Index);
    3: Result := SBindVerb;
  end;
end;

function TSDQueryEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;


{ TSDStoredProcEditor }
procedure TSDStoredProcEditor.ExecuteVerb(Index: Integer);
var
  sp: TSDStoredProc;
begin
  sp := Component as TSDStoredProc;
  case Index of
    0,
    2: inherited ExecuteVerb(Index);
    3: if ShowStoredProcParamsEditor(Designer, sp) and Assigned(Designer) then
         Designer.Modified;
  end;
end;

function TSDStoredProcEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0,
    1,
    2: Result := inherited GetVerb(Index);
    3: Result := SBindVerb;
  end;
end;

function TSDStoredProcEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

{ TSDUpdateSQLEditor }
procedure TSDUpdateSQLEditor.Edit;
begin
  ExecuteVerb(2);
end;

procedure TSDUpdateSQLEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowAboutBox;
    2: ShowUpdateSQLDesigner(Designer, TSDUpdateSQL(Component));
  end;
end;

function TSDUpdateSQLEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := GetAboutVerbName;
    1: Result := '-';
    2: Result := SUpdateSQLEditor;
  end;
end;

function TSDUpdateSQLEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

{ TSDScriptEditor }
procedure TSDScriptEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowAboutBox;
  end;
end;

function TSDScriptEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := GetAboutVerbName;
  end;
end;

function TSDScriptEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


{ TSDStringProperty }
function TSDStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TSDStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;


{ TSDSessionNameProperty }
procedure TSDSessionNameProperty.GetValueList(List: TStrings);
var
  i: Integer;
begin
  for i:=0 to Sessions.Count-1 do
    List.Add( Sessions[i].SessionName );
end;

{ TSDDatabaseNameProperty }
procedure TSDDatabaseNameProperty.GetValueList(List: TStrings);
var
  cmp: TPersistent;
begin
  cmp := GetComponent(0);
  if cmp is TSDScript then
    TSDScript(cmp).DBSession.GetDatabaseNames(List)
  else
    (cmp as TSDDataSet).DBSession.GetDatabaseNames(List);
end;

{ TSDStoredProcNameProperty }
procedure TSDStoredProcNameProperty.GetValueList(List: TStrings);
var
  sp: TSDStoredProc;
  db: TSDDatabase;
begin
  sp := (GetComponent(0) as TSDStoredProc);

  db := Sessions.FindDatabase( sp.DatabaseName );

  if (db = nil) and ((sp.Database = nil) or (not sp.Database.Connected)) then
    db := sp.OpenDatabase;      // it will raise 'Invalid session' exception, if session name is unknown
  if Assigned( db ) then
    Sessions.List[db.SessionName].GetStoredProcNames( db.DatabaseName, List );
end;


{ TSDParamsProperty }
function TSDParamsProperty.GetValue: string;
begin
  Result := Format('(%s)', [TSDHelperParams.ClassName]);
end;

function TSDParamsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;


{ TSDQueryParamsProperty }
procedure TSDQueryParamsProperty.Edit;
var
  q: TSDQuery;
begin
  q := GetComponent(0) as TSDQuery;
  if ShowQueryParamsEditor(Designer, q) then
    Modified;
end;

{ TSDStoredParamsProperty }
procedure TSDStoredProcParamsProperty.Edit;
var
  sp: TSDStoredProc;
begin
  sp := GetComponent(0) as TSDStoredProc;
  if ShowStoredProcParamsEditor(Designer, sp) then
    Modified;
end;

{ TSDTableNameProperty }

function TSDTableNameProperty.AutoFill: Boolean;
begin
  Result := IsDatabaseOpen(GetComponent(0) as TSDDataSet);
end;

procedure TSDTableNameProperty.GetValueList(AList: TStrings);
begin
  with GetComponent(0) as TSDTable do
    Session.GetTableNames(DatabaseName, '', False, AList);
end;

{$IFDEF SD_VCL5}

{ TSDTableFieldLinkProperty }

procedure TSDTableFieldLinkProperty.Edit;
var
  Table: TSDTable;
begin
  Table := DataSet as TSDTable;
  FTable := TSDTable.Create(nil);
  try
    FTable.SessionName := Table.SessionName;
    FTable.DatabaseName := Table.DatabaseName;
    FTable.TableName := Table.TableName;
    if Table.IndexFieldNames <> '' then
      FTable.IndexFieldNames := Table.IndexFieldNames
    else
      FTable.IndexName := Table.IndexName;
    FTable.MasterFields := Table.MasterFields;
    FTable.Open;
    inherited Edit;
    if Changed then begin
      Table.MasterFields := FTable.MasterFields;
      if FTable.IndexFieldNames <> '' then
        Table.IndexFieldNames := FTable.IndexFieldNames
      else
        Table.IndexName := FTable.IndexName;
    end;
  finally
    FTable.Free;
  end;
end;

procedure TSDTableFieldLinkProperty.GetFieldNamesForIndex(List: TStrings);
var
  i: Integer;
begin
  for i := 0 to FTable.IndexFieldCount - 1 do
    List.Add(FTable.IndexFields[i].FieldName);
end;

function TSDTableFieldLinkProperty.GetIndexBased: Boolean;
begin
  Result := not IProviderSupport(FTable).PSIsSQLBased;
end;

function TSDTableFieldLinkProperty.GetIndexDefs: TIndexDefs;
begin
  Result := FTable.IndexDefs;
end;

function TSDTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FTable.IndexFieldNames;
end;

function TSDTableFieldLinkProperty.GetIndexName: string;
begin
  Result := FTable.IndexName;
end;

function TSDTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := FTable.MasterFields;
end;

procedure TSDTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FTable.IndexFieldNames := Value;
end;

procedure TSDTableFieldLinkProperty.SetIndexName(const Value: string);
begin
  if Value = SPrimary then
    FTable.IndexName := '' else
    FTable.IndexName := Value;
end;

procedure TSDTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FTable.MasterFields := Value;
end;

{ TSDSessionSprig }
(*
function TSDSessionSprig.Name: string;
begin
  Result := TSDSession(Item).SessionName;
end;

function TSDSessionSprig.AnyProblems: Boolean;
begin
  Result := TSDSession(Item).SessionName = '';
end;

function TSDSessionSprig.Caption: string;
begin
  Result := CaptionFor(Name, UniqueName);
end;

{ TSDDatabaseSprig }

function TSDDatabaseSprig.Name: string;
begin
  Result := TSDDatabase(Item).DatabaseName;
end;

function TSDDatabaseSprig.AnyProblems: Boolean;
begin
  Result := TSDDatabase(Item).DatabaseName = '';
end;

function TSDDatabaseSprig.Caption: string;
var
  vName: string;
begin
  vName := Name;
  if TSDDatabase(Item).DatabaseName <> '' then
    Result := Format('%s:%s', [vName, TSDDatabase(Item).DatabaseName]); { Do not localize }
  Result := CaptionFor(vName, UniqueName);
end;
 {
procedure TDatabaseSprig.FigureParent;
var
  vSessionName: string;
  vSession: TSprig;
begin
  with TDatabase(Item) do
  begin
    // find real or default session
    vSessionName := SprigBDESessionName(SessionName);
    vSession := Root.Find(vSessionName, False);

    // if not found see if its the default session
    if (vSession = nil) and
       (vSessionName = cDefaultSessionSprigName) then
      vSession := Root.Add(TDefaultSessionSprig.Create(nil));

    // still not found, try for an implied session
    if vSession = nil then
    begin
      vSession := Root.Find(SprigBDEImpliedSessionName(SessionName), False);

      // if not make an implied session
      if vSession = nil then
      begin
        vSession := Root.Add(TImpliedSessionSprig.Create(nil));
        TImpliedSessionSprig(vSession).FSessionName := SessionName;
      end;
    end;

    // well put it
    vSession.Add(Self);
  end;
end;

function TDatabaseSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  if AItem is TSessionSprig then
  begin
    Result := not AnsiSameText(TSession(AItem.Item).SessionName, TDatabase(Item).SessionName);
    if Result then
      TDatabase(Item).SessionName := TSession(AItem.Item).SessionName;
  end
  else if AItem is TImpliedSessionSprig then
  begin
    Result := not AnsiSameText(TImpliedSessionSprig(AItem).FSessionName, TDatabase(Item).SessionName);
    if Result then
      TDatabase(Item).SessionName := TImpliedSessionSprig(AItem).FSessionName;
  end
  else if AItem is TDefaultSessionSprig then
  begin
    Result := not AnsiSameText(TDatabase(Item).SessionName, Session.SessionName) or
              (TDatabase(Item).SessionName <> '');
    if Result then
      TDatabase(Item).SessionName := '';
  end
  else
    Result := False;
  ReparentChildren;
end;

function TDatabaseSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := ((AItem is TSessionSprig) and (TSession(AItem.Item).SessionName <> '')) or
            (AItem is TImpliedSessionSprig) or
            (AItem is TDefaultSessionSprig);
end;

class function TDatabaseSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := ((AParent is TSessionSprig) and (TSession(AParent.Item).SessionName <> '')) or
            (AParent is TImpliedSessionSprig) or
            (AParent is TDefaultSessionSprig);
end;
}
{ TSDDataSetSprig }

function TSDDataSetSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TSDDataSet(Item).DatabaseName = '');
end;

{ TSDTableSprig }

function TSDTableSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TSDTable(Item).TableName = '');
end;

function TSDTableSprig.Caption: string;
begin
  Result := CaptionFor(TSDTable(Item).TableName, UniqueName);
end;

{ TSDQuerySprig }

function TSDQuerySprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TSDQuery(Item).SQL.Count = 0);
end;

{ TSDStoredProcSprig }

function TSDStoredProcSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TSDStoredProc(Item).StoredProcName = '');
end;

function TSDStoredProcSprig.Caption: string;
begin
  Result := CaptionFor(TSDStoredProc(Item).StoredProcName, UniqueName);
end;

{ TSDUpdateSQLSprig }

function TSDUpdateSQLSprig.AnyProblems: Boolean;
begin
  with TSDUpdateSQL(Item) do
    Result := (ModifySQL.Count = 0) and
              (InsertSQL.Count = 0) and
              (DeleteSQL.Count = 0);
end;

{ TSDQueryMasterDetailBridge }

function TSDQueryMasterDetailBridge.Caption: string;
begin
  Result := SParamsFields;
end;

class function TSDQueryMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TSDQuery(AItem).DataSource;
end;

class function TSDQueryMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TSDQueryIsland;
end;

class function TSDQueryMasterDetailBridge.RemoveMasterFieldsAsWell: Boolean;
begin
  Result := False;
end;

class procedure TSDQueryMasterDetailBridge.SetOmegaSource(AItem: TPersistent;
  ADataSource: TDataSource);
begin
  TSDQuery(AItem).DataSource := ADataSource;
end;

{ TSDTableMasterDetailBridge }

class function TSDTableMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TSDTable(AItem).MasterSource;
end;

class function TSDTableMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TSDTableIsland;
end;

class procedure TSDTableMasterDetailBridge.SetOmegaSource(AItem: TPersistent;
  ADataSource: TDataSource);
begin
  TSDTable(AItem).MasterSource := ADataSource;
end;

function TSDTableMasterDetailBridge.CanEdit: Boolean;
begin
  Result := True;
end;

function TSDTableMasterDetailBridge.Edit: Boolean;
var
  vPropEd: TSDTableFieldLinkProperty;
begin
  vPropEd := TSDTableFieldLinkProperty.CreateWith(TDataSet(Omega.Item));
  try
    vPropEd.Edit;
    Result := vPropEd.Changed;
  finally
    vPropEd.Free;
  end;
end;

function TSDTableMasterDetailBridge.Caption: string;
begin
  if TSDTable(Omega.Item).MasterFields = '' then
    Result := SNoMasterFields
  else
    Result := TSDTable(Omega.Item).MasterFields;
end;
 *)
{$ENDIF}

procedure Register;
begin
{$IFDEF EVAL}
  ShowReminderBox;
{$ENDIF}

  RegisterComponents(srSQLDirect, [TSDSession, TSDDatabase, TSDQuery, TSDMacroQuery, TSDStoredProc, TSDTable, TSDUpdateSQL, TSDScript, TSDSQLBaseServer]);

  RegisterPropertyEditor(TypeInfo(string),	TSDDatabase, 'SessionName', TSDSessionNameProperty);
  RegisterPropertyEditor(TypeInfo(string),	TSDDataSet, 'DatabaseName', TSDDatabaseNameProperty);
  RegisterPropertyEditor(TypeInfo(string),	TSDDataSet, 'SessionName', TSDSessionNameProperty);
  RegisterPropertyEditor(TypeInfo(string),	TSDScript, 'DatabaseName', TSDDatabaseNameProperty);
  RegisterPropertyEditor(TypeInfo(string),	TSDScript, 'SessionName', TSDSessionNameProperty);
  RegisterPropertyEditor(TypeInfo(string), 	TSDStoredProc, 'StoredProcName', TSDStoredProcNameProperty);
  RegisterPropertyEditor(TypeInfo(string), 	TSDTable, 'TableName', TSDTableNameProperty);
{$IFDEF SD_VCL5}
  RegisterPropertyEditor(TypeInfo(string), 	TSDTable, 'IndexName', TIndexNameProperty);
  RegisterPropertyEditor(TypeInfo(string), 	TSDTable, 'IndexFieldNames', TIndexFieldNamesProperty);
  RegisterPropertyEditor(TypeInfo(string), 	TSDTable, 'MasterFields', TSDTableFieldLinkProperty);
{$ENDIF}

{$IFDEF SD_VCL4}
  RegisterPropertyEditor(TypeInfo(TParams),	TSDQuery, 'Params', TSDQueryParamsProperty);
  RegisterPropertyEditor(TypeInfo(TParams),	TSDStoredProc, 'Params', TSDStoredProcParamsProperty);
{$ELSE}
  RegisterPropertyEditor(TypeInfo(TSDParams),	TSDQuery, 'Params', TSDQueryParamsProperty);
  RegisterPropertyEditor(TypeInfo(TSDParams),	TSDStoredProc, 'Params', TSDStoredProcParamsProperty);
{$ENDIF}
  RegisterComponentEditor(TSDSession, TSDDefaultEditor);
  RegisterComponentEditor(TSDDatabase, TSDDefaultEditor);

  RegisterComponentEditor(TSDDataSet, TSDDataSetEditor);
  RegisterComponentEditor(TSDQuery, TSDQueryEditor);
  RegisterComponentEditor(TSDStoredProc, TSDStoredProcEditor);
  RegisterComponentEditor(TSDUpdateSQL, TSDUpdateSQLEditor);
  RegisterComponentEditor(TSDScript, TSDScriptEditor);  

  RegisterComponentEditor(TSDSQLBaseServer, TSDDefaultEditor);

{$IFDEF SD_VCL5}
    { Property Category registration }
  RegisterPropertiesInCategory(
        {$IFDEF SD_VCL6}sDatabaseCategoryName{$ELSE}TDatabaseCategory{$ENDIF},
        TSDDatabase,
        ['ServerType', 'SessionName', 'DatabaseName', 'RemoteDatabase']);

  RegisterPropertiesInCategory(
        {$IFDEF SD_VCL6}sDatabaseCategoryName{$ELSE}TDatabaseCategory{$ENDIF},
        TSDDataSet,
        ['DatabaseName']);

  RegisterPropertiesInCategory(
        {$IFDEF SD_VCL6}sDatabaseCategoryName{$ELSE}TDatabaseCategory{$ENDIF},
        TSDDataSetUpdateObject,
        ['*SQL']);

(* implement later
	{ Register leaf types in Delphi's Object Treeview (TreeIntf.pas) }
  RegisterSprigType(TSDSession, TSDSessionSprig);
  RegisterSprigType(TSDDatabase, TSDDatabaseSprig);
  RegisterSprigType(TSDDataSet, TSDDataSetSprig);
  RegisterSprigType(TSDTable, TSDTableSprig);
  RegisterSprigType(TSDQuery, TSDQuerySprig);
  RegisterSprigType(TSDStoredProc, TSDStoredProcSprig);
  RegisterSprigType(TSDUpdateSQL, TSDUpdateSQLSprig);
	{ (DiagramSupport.pas) }
  RegisterIslandType(TSDDataSetSprig, TSDDataSetIsland);
  RegisterIslandType(TSDTableSprig, TSDTableIsland);
  RegisterIslandType(TSDQuerySprig, TSDQueryIsland);

  RegisterBridgeType(TDataSetIsland, TSDQueryIsland, TSDQueryMasterDetailBridge);
  RegisterBridgeType(TDataSetIsland, TSDTableIsland, TSDTableMasterDetailBridge);
*)
{$ENDIF}
end;

end.
