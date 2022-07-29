{$I QBDEF.INC}

unit QBuilder_SQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, ComCtrls, ToolWin, Menus, CheckLst, Grids,
  DB, DBGrids, ExtDlgs, ImgList, SynEditHighlighter, SynHighlighterSQL,
  SynEdit, SDEngine, SynCompletionProposal;

type
  TOQBbutton = (bSelectDBDialog, bOpenDialog, bSaveDialog,
    bRunQuery, bSaveResultsDialog);
  TOQBbuttons = set of TOQBbutton;

  TOQBEngine = class;

  TOQBuilderDialog_SQL = class(TComponent)
  private
    FDatabase: string;
    FSystemTables: Boolean;
    FOQBForm: TForm;
    FSQL: TStrings;
    FSQL_Layout: TSTrings;
    FOQBEngine: TOQBEngine;
    FShowButtons: TOQBbuttons;
    procedure SetOQBEngine(const Value: TOQBEngine);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; virtual;
    property SQL: TStrings read FSQL;
    property SQL_Layout: TStrings read FSQL_Layout;
    property SystemTables: Boolean read FSystemTables write FSystemTables default False;
    property Database: string read FDatabase write FDatabase;
  published
    property OQBEngine: TOQBEngine read FOQBEngine write SetOQBEngine;
    property ShowButtons: TOQBbuttons read FShowButtons write FShowButtons
      default [bSelectDBDialog, bOpenDialog, bSaveDialog, bRunQuery, bSaveResultsDialog];
  end;

  TOQBEngine = class(TComponent)
  private
    FDatabaseName: string;
    FUserName: string;
    FPassword: string;
    FShowSystemTables: Boolean;
    FTableList: TStringList;
    FAliasList: TStringList;
    FFieldList: TStringList;
    FSQL: TStringList;
    FSQLcolumns: TStringList;
    FSQLcolumns_table: TStringList;
    FSQLcolumns_func: TStringList;
    FSQLfrom: TStringList;
    FSQLwhere: TStringList;
    FSQLgroupby: TStringList;
    FSQLorderby: TStringList;
    FUseTableAliases: Boolean;
    FOQBDialog: TOQBuilderDialog_SQL;
    procedure SetShowSystemTables(const Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetDatabaseName(const Value: string); virtual;
    procedure SetUserName(const Value: string); virtual;
    procedure SetPassword(const Value: string); virtual;
    procedure SetQuerySQL(const Value: string); virtual; abstract;
    procedure GenerateAliases; virtual;
    procedure ReadTableList; virtual; abstract;
    procedure ReadFieldList(const ATableName: string); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function SelectDatabase: Boolean; virtual; abstract;
    function GenerateSQL: string; virtual;
    procedure ClearQuerySQL; virtual; abstract;
    function ResultQuery: TDataSet; virtual; abstract;
    procedure OpenResultQuery; virtual; abstract;
    procedure CloseResultQuery; virtual; abstract;
    procedure SaveResultQueryData; virtual; abstract;
    property TableList: TStringList read FTableList;
    property AliasList: TStringList read FAliasList;
    property FieldList: TStringList read FFieldList;
    property SQL: TStringList read FSQL;
    property SQLcolumns: TStringList read FSQLcolumns;
    property SQLcolumns_table: TStringList read FSQLcolumns_table;
    property SQLcolumns_func: TStringList read FSQLcolumns_func;
    property SQLfrom: TStringList read FSQLfrom;
    property SQLwhere: TStringList read FSQLwhere;
    property SQLgroupby: TStringList read FSQLgroupby;
    property SQLorderby: TStringList read FSQLorderby;
    property UserName: string  read FUserName write SetUserName;
    property Password: string  read FPassword write SetPassword;
  published
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property ShowSystemTables: Boolean read FShowSystemTables write SetShowSystemTables default False;
    property UseTableAliases: Boolean read FUseTableAliases write FUseTableAliases default True;
  end;

type
  TArr = array [0..0] of Integer;
  PArr = ^TArr;

  TOQBLbx = class(TCheckListBox)
  private
    FArrBold: PArr;
    FLoading: Boolean;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DrawItem;
    procedure WMLButtonDown(var Message: TWMLButtonDblClk); message WM_LButtonDown;
    procedure WMRButtonDown(var Message: TWMRButtonDblClk); message WM_RButtonDown;
    function GetCheckW: Integer;
    procedure AllocArrBold;
    procedure SelectItemBold(Item: Integer);
    procedure UnSelectItemBold(Item: Integer);
    function GetItemY(Item: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClickCheck; override;
  end;

  TOQBTable = class(TPanel)
  private
    ScreenDC: HDC;
    OldX: Integer;
    OldY: Integer;
    OldLeft: Integer;
    OldTop: Integer;
    ClipRgn: HRGN;
    ClipRect: TRect;
    MoveRect: TRect;
    Moving: Boolean;
    FCloseBtn: TSpeedButton;
    FUnlinkBtn: TSpeedButton;
    FLbx: TOQBLbx;
    FTableName: string;
    FTableAlias: string;
    PopMenu: TPopupMenu;
    procedure WMRButtonDown(var Message: TWMRButtonDblClk); message WM_RButtonDown;
    function Activate(const ATableName: string; X, Y: Integer): Boolean;
    function GetRowY(FldN: Integer):Integer;
    procedure _CloseBtn(Sender: TObject);
    procedure _UnlinkBtn(Sender: TObject);
    procedure _SelectAll(Sender: TObject);
    procedure _UnSelectAll(Sender: TObject);
    procedure _DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure _DragDrop(Sender, Source: TObject; X, Y: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    property Align;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  end;

  TOQBLink = class(TShape)
  private
    Tbl1: TOQBTable;
    Tbl2: TOQBTable;
    FldN1: Integer;
    FldN2: Integer;
    FldNam1: string;
    FldNam2: string;
    FLinkOpt: Integer;
    FLinkType: Integer;
    LnkX: Byte;
    LnkY: Byte;
    Rgn: HRgn;
    PopMenu: TPopupMenu;
    procedure _Click(X, Y: Integer);
    procedure CMHitTest(var Message: TCMHitTest); message CM_HitTest;
    function ControlAtPos(const Pos: TPoint): TControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
  end;

  TOQBArea = class(TScrollBox)
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetOptions(Sender: TObject);
    procedure InsertTable(X, Y: Integer);
    function InsertLink(_tbl1, _tbl2: TOQBTable; _fldN1, _fldN2: Integer): TOQBLink;
    function FindTable(const TableName: string): TOQBTable;
    function FindLink(Link: TOQBLink): Boolean;
    function FindOtherLink(Link: TOQBLink; Tbl: TOQBTable; FldN: Integer): Boolean;
    procedure ReboundLink(Link: TOQBLink);
    procedure ReboundLinks4Table(ATable: TOQBTable);
    procedure Unlink(Sender: TObject);
    procedure UnlinkTable(ATable: TOQBTable);
    procedure _DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure _DragDrop(Sender, Source: TObject; X, Y: Integer);
  end;

  TOQBGrid = class(TStringGrid)
  public
    CurrCol: Integer;
    IsEmpty: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
    function MaxSW(const s1, s2: string): Integer;
    procedure InsertDefault(aCol: Integer);
    procedure Insert(aCol: Integer; const aField, aTable: string);
    function FindColumn(const sCol: string): Integer;
    function FindSameColumn(aCol: Integer): Boolean;
    procedure RemoveColumn(aCol: Integer);
    procedure RemoveColumn4Tbl(const Tbl: string);
    procedure ClickCell(X, Y: Integer);
    function SelectCell(ACol, ARow: Integer): Boolean; override;
    procedure _DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure _DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Inicializa;
  end;

  TOQBForm_SQL = class(TForm)
    QBPanel: TPanel;
    Pages: TPageControl;
    TabColumns: TTabSheet;
    QBTables: TListBox;
    VSplitter: TSplitter;
    mnuTbl: TPopupMenu;
    Remove1: TMenuItem;
    mnuFunc: TPopupMenu;
    Nofunction1: TMenuItem;
    N1: TMenuItem;
    Average1: TMenuItem;
    Count1: TMenuItem;
    Minimum1: TMenuItem;
    Maximum1: TMenuItem;
    Sum1: TMenuItem;
    mnuGroup: TPopupMenu;
    Group1: TMenuItem;
    mnuSort: TPopupMenu;
    Sort1: TMenuItem;
    N2: TMenuItem;
    Ascending1: TMenuItem;
    Descending1: TMenuItem;
    mnuShow: TPopupMenu;
    Show1: TMenuItem;
    HSplitter: TSplitter;
    TabSQL: TTabSheet;
    TabResults: TTabSheet;
    ResDBGrid: TDBGrid;
    ResDataSource: TDataSource;
    QBBar: TToolBar;
    btnNew: TToolButton;
    btnOpen: TToolButton;
    btnSave: TToolButton;
    ToolButton1: TToolButton;
    btnTables: TToolButton;
    ToolImages: TImageList;
    btnPages: TToolButton;
    ToolButton2: TToolButton;
    DlgSave: TSaveDialog;
    DlgOpen: TOpenDialog;
    btnDB: TToolButton;
    btnSQL: TToolButton;
    btnResults: TToolButton;
    ToolButton3: TToolButton;
    btnSaveResults: TToolButton;
    btnOK: TToolButton;
    btnCancel: TToolButton;
    Image1: TImage;
    MemoSQL: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    SDDatabase: TSDDatabase;
    SDQuery: TSDQuery;
    BtnParametros: TToolButton;
    Lista_Parametros: TSynCompletionProposal;
    BtnTitulos: TToolButton;
    procedure mnuFunctionClick(Sender: TObject);
    procedure mnuGroupClick(Sender: TObject);
    procedure mnuRemoveClick(Sender: TObject);
    procedure mnuShowClick(Sender: TObject);
    procedure mnuSortClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnTablesClick(Sender: TObject);
    procedure btnPagesClick(Sender: TObject);
    procedure btnDBClick(Sender: TObject);
    procedure btnSQLClick(Sender: TObject);
    procedure btnResultsClick(Sender: TObject);
    procedure btnSaveResultsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure QBTablesDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnParametrosClick(Sender: TObject);
    procedure BtnTitulosClick(Sender: TObject);
  protected
    QBDialog: TOQBuilderDialog_SQL;
    QBArea: TOQBArea;
    QBGrid: TOQBGrid;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ClearAll;
    procedure AtualizaLista_P;
    procedure OpenDatabase;
    procedure SelectDatabase;
  end;

implementation

//{$R QBBUTTON.RES}

uses
  QBLnkFrm, QBAbout, Abertura, Estrutura_Case, Rotinas, Gera_01,
  EdParametros, EdTitulos;

{$R *.DFM}

resourcestring
  sMainCaption = 'SQL';
  sNotValidTableParent = 'Área inválida.';

const
  cFld = 0;
  cTbl = 1;
  cShow = 2;
  cSort = 3;
  cFunc = 4;
  cGroup = 5;

  sShow = 'Sim';
  sGroup = 'Sim';
  sSort: array [1..3] of string =
    ('',
     'Asc',
     'Desc');
  sFunc: array [1..6] of string =
    ('',
     'Avg',
     'Count',
     'Max',
     'Min',
     'Sum');

  sLinkOpt: array [0..5] of string =
    ('=',
     '<',
     '>',
     '=<',
     '=>',
     '<>');

  sOuterJoin: array [1..3] of string =
    (' LEFT OUTER JOIN ',
     ' RIGHT OUTER JOIN ',
     ' FULL OUTER JOIN ');

  Hand = 15;
  Hand2 = 12;

  QBSignature = '# SQL';


{ TQueryBuilderDialog}

constructor TOQBuilderDialog_SQL.Create(AOwner: TComponent);
begin
  inherited;
  FSystemTables := False;
  FShowButtons := [bSelectDBDialog, bOpenDialog, bSaveDialog,
    bRunQuery, bSaveResultsDialog];
  FSQL := TStringList.Create;
  FSQL_Layout := TStringList.Create;
end;

destructor TOQBuilderDialog_SQL.Destroy;
begin
  if FSQL <> nil then
    FSQL.Free;
  if FSQL_Layout <> nil then
    FSQL_Layout.Free;
  FOQBEngine := nil;
  inherited;
end;

function TOQBuilderDialog_SQL.Execute: Boolean;
begin
  Result := False;
  if (not Assigned(FOQBForm)) and Assigned((FOQBEngine)) then
  begin
    TOQBForm_SQL(FOQBForm) := TOQBForm_SQL.Create(Application);
    TOQBForm_SQL(FOQBForm).QBDialog := Self;
    //TOQBForm_SQL(FOQBForm).btnDB.Visible := bSelectDBDialog in FShowButtons;
    //TOQBForm_SQL(FOQBForm).btnOpen.Visible := bOpenDialog in FShowButtons;
    //TOQBForm_SQL(FOQBForm).btnSave.Visible := bSaveDialog in FShowButtons;
    TOQBForm_SQL(FOQBForm).btnResults.Visible := bRunQuery in FShowButtons;
    //TOQBForm_SQL(FOQBForm).btnSaveResults.Visible := bSaveResultsDialog in FShowButtons;

    if OQBEngine.DatabaseName <> EmptyStr then
      TOQBForm_SQL(FOQBForm).OpenDatabase else
      TOQBForm_SQL(FOQBForm).SelectDatabase;

    TOQBForm_SQL(FOQBForm).btnOpenClick(Self);

    if TOQBForm_SQL(FOQBForm).ShowModal = mrOk then
    begin
      FSQL.Assign(TOQBForm_SQL(FOQBForm).MemoSQL.Lines);
      Result := True;
    end;

    OQBEngine.CloseResultQuery;
    FOQBForm.Free;
    FOQBForm := nil;
  end;
end;

procedure TOQBuilderDialog_SQL.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FOQBEngine) and (Operation = opRemove) then
    FOQBEngine := nil;
end;

procedure TOQBuilderDialog_SQL.SetOQBEngine(const Value: TOQBEngine);
begin
  if FOQBEngine <> nil then
    FOQBEngine.FOQBDialog := nil;
  FOQBEngine := Value;
  if FOQBEngine <> nil then
  begin
    FOQBEngine.FOQBDialog := Self;
    FOQBEngine.FreeNotification(Self);
  end;
end;


{ TOQBEngine }

constructor TOQBEngine.Create(AOwner: TComponent);
begin
  inherited;
  FShowSystemTables := False;
  FTableList := TStringList.Create;
  FAliasList := TStringList.Create;
  FFieldList := TStringList.Create;
  FSQL := TStringList.Create;
  FSQLcolumns := TStringList.Create;
  FSQLcolumns_table := TStringList.Create;
  FSQLcolumns_func := TStringList.Create;
  FSQLfrom := TStringList.Create;
  FSQLwhere := TStringList.Create;
  FSQLgroupby := TStringList.Create;
  FSQLorderby := TStringList.Create;
  FUseTableAliases := True;
end;

destructor TOQBEngine.Destroy;
begin
  FSQL.Free;
  FSQLcolumns.Free;
  FSQLcolumns_table.Free;
  FSQLcolumns_func.Free;
  FSQLfrom.Free;
  FSQLwhere.Free;
  FSQLgroupby.Free;
  FSQLorderby.Free;
  FFieldList.Free;
  FAliasList.Free;
  FTableList.Free;
  FreeNotification(Self);
  inherited;
end;

procedure TOQBEngine.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FOQBDialog) and (Operation = opRemove) then
    FOQBDialog := nil;
end;

procedure TOQBEngine.SetDatabaseName(const Value: string);
begin
  TableList.Clear;
  FDatabaseName := Value;
  if ResultQuery.Active then
    ResultQuery.Close;
end;

procedure TOQBEngine.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

procedure TOQBEngine.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TOQBEngine.SetShowSystemTables(const Value: Boolean);
begin
  if FShowSystemTables <> Value then
    FShowSystemTables := Value;
end;

procedure TOQBEngine.GenerateAliases;
var
  i, j: Integer;
  s, s1: string;
begin
  FAliasList.Clear;
  for i := 0 to FTableList.Count - 1 do
  begin
    s := ' ';
    s[1] := FTableList[i][1]; // get the first character [1] of the table name [i]
    if FAliasList.IndexOf(s) = -1 then
      FAliasList.Add(s)
    else
    begin
      j := 1;
      repeat
        Inc(j);
        s1 := s + IntToStr(j);
      until FAliasList.IndexOf(s1) = -1;
      FAliasList.Add(s1);
    end;
  end;
end;

function TOQBEngine.GenerateSQL: string;
var
  s: string;
  i: Integer;
begin
  SQL.Clear;

  s := 'SELECT  ';
  for i := 0 to SQLcolumns.Count - 1 do
  begin
    if SQLcolumns_func[i] = EmptyStr then
      s := s + SQLcolumns[i] else
      s := s + SQLcolumns_func[i] + '(' + SQLcolumns[i] + ')';
    if (i < SQLcolumns.Count - 1) then
      s := s + ', ';
    if (Length(s) > 70) or (i = SQLcolumns.Count - 1) then
    begin
      SQL.Add(s);
      s := '  ';
    end;
  end;

  s := 'FROM  ';
  for i := 0 to SQLfrom.Count - 1 do
  begin
    s := s + SQLfrom[i];
    if (i < SQLfrom.Count - 1) then
      s := s + ', ';
    if (Length(s) > 70) or (i = SQLfrom.Count - 1) then
    begin
      SQL.Add(s);
      s := '  ';
    end;
  end;

  s := 'WHERE  ';
  for i := 0 to SQLwhere.Count - 1 do
  begin
    if (i < SQLwhere.Count - 1) then
      s := s + SQLwhere[i] + ' AND ' else
      s := s + SQLwhere[i];
    if (Length(s) > 70) or (i = SQLwhere.Count - 1) then
    begin
      SQL.Add(s);
      s := '  ';
    end;
  end;

  s := 'GROUP BY  ';
  for i := 0 to SQLgroupby.Count - 1 do
  begin
    if (i < SQLgroupby.Count - 1) then
      s := s + SQLgroupby[i] + ', ' else
      s := s + SQLgroupby[i];
    if (Length(s) > 70) or (i = SQLgroupby.Count - 1) then
    begin
      SQL.Add(s);
      s := '  ';
    end;
  end;

  s := 'ORDER BY  ';
  for i := 0 to SQLorderby.Count - 1 do
  begin
    if (i < SQLorderby.Count - 1) then
      s := s + SQLorderby[i] + ', ' else
      s := s + SQLorderby[i];
    if (Length(s) > 70) or (i = SQLorderby.Count - 1) then
    begin
      SQL.Add(s);
      s := '  ';
    end;
  end;

  Result := SQL.Text;
end;


{ TOQBLbx }

constructor TOQBLbx.Create(AOwner: TComponent);
begin
  inherited;
  Style := lbOwnerDrawFixed;
  ParentFont := False;
  Font.Style := [];
  Font.Size := 8;
  FArrBold := nil;
  FLoading := False;
end;

destructor TOQBLbx.Destroy;
begin
  if FArrBold <> nil then
    FreeMem(FArrBold);
  inherited;
end;

function TOQBLbx.GetCheckW: Integer;
begin
  Result := GetCheckWidth;
end;

procedure TOQBLbx.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do
  begin
    rcItem.Left := rcItem.Left + GetCheckWidth;  //*** check
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (Integer(itemID) <= Items.Count - 1) then
    begin
      if (FArrBold <> nil) then
        if FArrBold^[Integer(itemID)] = 1 then
          Canvas.Font.Style := [fsBold];
      if Integer(Items.Objects[itemID]) = 1 then
      begin
        Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];
        Canvas.Font.Color := clBlue;
      end;
      if Integer(Items.Objects[itemID]) = 2 then
      begin
        Canvas.Font.Style := Canvas.Font.Style + [fsItalic];
        Canvas.Font.Color := clRed;
      end;
      DrawItem(itemID, rcItem, []);
      if (FArrBold <> nil) then
        if FArrBold^[Integer(itemID)] = 1 then
          Canvas.Font.Style := [];
    end
    else
      Canvas.FillRect(rcItem);
  end;
end;

procedure TOQBLbx.WMLButtonDown(var Message: TWMLButtonDblClk);
begin
  inherited;
  BeginDrag(False);
end;

procedure TOQBLbx.WMRButtonDown(var Message: TWMLButtonDblClk);
var
  pnt: TPoint;
begin
  inherited;
  pnt.X := Message.XPos;
  pnt.Y := Message.YPos;
  pnt := ClientToScreen(pnt);
  PopupMenu.Popup(pnt.X, pnt.Y);
end;

procedure TOQBLbx.ClickCheck;
var
  iCol: Integer;
begin
  inherited;
  if FLoading then
    Exit;

  if Checked[ItemIndex] then
  begin
    TOQBForm_SQL(GetParentForm(Self)).QBGrid.Insert(
      TOQBForm_SQL(GetParentForm(Self)).QBGrid.ColCount,
      Items[ItemIndex], TOQBTable(Parent).FTableName);
  end
  else
  begin
    iCol := TOQBForm_SQL(GetParentForm(Self)).QBGrid.FindColumn(Items[ItemIndex]);
    while iCol <> -1 do
    begin
      TOQBForm_SQL(GetParentForm(Self)).QBGrid.RemoveColumn(iCol);
      iCol := TOQBForm_SQL(GetParentForm(Self)).QBGrid.FindColumn(Items[ItemIndex]);
    end;
  end;

  TOQBForm_SQL(GetParentForm(Self)).QBGrid.Refresh; // StringGrid bug
end;

procedure TOQBLbx.AllocArrBold;
begin
  FArrBold := AllocMem(Items.Count * SizeOf(Integer));
end;

procedure TOQBLbx.SelectItemBold(Item: Integer);
begin
  if FArrBold <> nil then
    if FArrBold[Item] = 0 then
      FArrBold^[Item] := 1;
end;

procedure TOQBLbx.UnSelectItemBold(Item: Integer);
begin
  if FArrBold <> nil then
    if FArrBold[Item] = 1 then
      FArrBold^[Item] := 0;
end;

function TOQBLbx.GetItemY(Item: Integer): Integer;
begin
  Result := Item * ItemHeight + ItemHeight div 2  + 1;
end;


{ TOQBTable }

constructor TOQBTable.Create(AOwner: TComponent);
var
  mnuArr: array [1..5] of TMenuItem;
begin
  inherited;
  Visible := False;
  ShowHint := True;
  BevelInner := bvRaised;
  BevelOuter := bvRaised;
  BorderWidth := 1;
  FCloseBtn := TSpeedButton.Create(Self);
  FCloseBtn.Parent := Self;
  FCloseBtn.Hint := 'Close';
  FUnlinkBtn := TSpeedButton.Create(Self);
  FUnlinkBtn.Parent := Self;
  FUnlinkBtn.Hint := 'Unlink';

  FLbx := TOQBLbx.Create(Self);
  FLbx.Parent := Self;
  FLbx.Style := lbOwnerDrawFixed;
  FLbx.Align := alBottom;
  FLbx.TabStop := False;
  FLbx.Visible := False;

  mnuArr[1] := NewItem('Selecionar tudo', 0, False, True, _SelectAll, 0, 'mnuSelectAll');
  mnuArr[2] := NewItem('Retirar seleção', 0, False, True, _UnSelectAll, 0, 'mnuUnSelectAll');
  mnuArr[3] := NewLine;
  mnuArr[4] := NewItem('Remover Relacionamentos', 0, False, True, _UnlinkBtn, 0, 'mnuUnLink');
  mnuArr[5] := NewItem('Fechar', 0, False, True, _CloseBtn, 0, 'mnuClose');
  PopMenu := NewPopupMenu(Self, 'mnu', paLeft, False, mnuArr);
  PopMenu.PopupComponent := Self;

  FLbx.PopupMenu := PopMenu;
end;

procedure TOQBTable.WMRButtonDown(var Message: TWMLButtonDblClk);
var
  pnt: TPoint;
begin
  inherited;
  pnt.X := Message.XPos;
  pnt.Y := Message.YPos;
  pnt := ClientToScreen(pnt);
  PopMenu.Popup(pnt.X, pnt.Y);
end;

procedure TOQBTable.Paint;
begin
  inherited;
  if TOQBForm_SQL(GetParentForm(Self)).QBDialog.OQBEngine.UseTableAliases then
    Canvas.TextOut(4, 4, FTableName + ' : ' + FTableAlias) else
    Canvas.TextOut(4, 4, FTableName);
end;

function TOQBTable.GetRowY(FldN: Integer): Integer;
var
  pnt: TPoint;
begin
  pnt.X := FLbx.Left;
  pnt.Y := FLbx.Top + FLbx.GetItemY(FldN);
  pnt := Parent.ScreenToClient(ClientToScreen(pnt));
  Result := pnt.Y;
end;

function TOQBTable.Activate(const ATableName: string; X, Y: Integer): Boolean;
var
  i, p: Integer;
  W, W1: Integer;
  OQBEngine: TOQBEngine;
begin
  Result := False;
  Top := Y;
  Left := X;
  Font.Style := [fsBold];
  Font.Size := 8;
  Canvas.Font := Font;
  Hint := ATableName;

  FTableName := ATableName;
  //FTableAlias := TOQBForm_SQL(GetParentForm(Self)).QBDialog.FOQBEngine.AliasList[
  //  TOQBForm_SQL(GetParentForm(Self)).QBDialog.FOQBEngine.TableList.IndexOf(ATableName)];
  //OQBEngine := TOQBForm_SQL(GetParentForm(Self)).QBDialog.FOQBEngine;
  //try
  //  OQBEngine.ReadFieldList(ATableName);
  //  FLbx.Items.Assign(OQBEngine.FieldList);
  //except
  //  on E: EDatabaseError do
  //    begin
  //      ShowMessage(E.Message);
  //      Exit;
  //    end;
  //end;
  p := TOQBForm_SQL(GetParentForm(Self)).QBTables.Items.IndexOf(ATableName);
  if p > -1 then
    TabGlobal_i.DTABELAS.GotoBookmark(TOQBForm_SQL(GetParentForm(Self)).QBTables.Items.Objects[P]);
  TabGlobal_i.DCAMPOST.First;
  TabGlobal_i.DCAMPOST.Locate('numero', TabGlobal_i.DTABELAS.NUMERO.Conteudo, []);
  FLbx.Items.AddObject('*', TObject(0));
  while (TabGlobal_i.DCAMPOST.NUMERO.Conteudo = TabGlobal_i.DTABELAS.NUMERO.Conteudo) and (not TabGlobal_i.DCAMPOST.Eof) do
  begin
    if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
      FLbx.Items.AddObject(NomeFisicoCampo, TObject(1))
    else if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
      FLbx.Items.AddObject(NomeFisicoCampo, TObject(2))
    else
      FLbx.Items.AddObject(NomeFisicoCampo, TObject(0));
    TabGlobal_i.DCAMPOST.Next;
  end;

  FLbx.AllocArrBold;
  FLbx.ParentFont := False;
  FLbx.TabStop := False;
  FLbx.Height := FLbx.ItemHeight * FLbx.Items.Count + 4;

  Height := FLbx.Height + 22;
  W := 110;
  for i := 0 to FLbx.Items.Count - 1 do
  begin
    W1 := Canvas.TextWidth(FLbx.Items[i]);
    if W < W1 then
      W := W1;
  end;
  Width := W + 20 + FLbx.GetCheckW; //*** check

  if TOQBForm_SQL(GetParentForm(Self)).QBDialog.OQBEngine.UseTableAliases then
  begin
    if Canvas.TextWidth(FTableName + ' : ' + FTableAlias) > Width - 34 then
      Width := Canvas.TextWidth(FTableName + ' : ' + FTableAlias) + 34
  end
  else if Canvas.TextWidth(FTableName) > Width - 34 then
    Width := Canvas.TextWidth(FTableName) + 34;

  FLbx.Visible := True;
  FLbx.OnDragOver := _DragOver;
  FLbx.OnDragDrop := _DragDrop;
  FCloseBtn.Top := 4;
  FCloseBtn.Left := Self.ClientWidth - 16;
  FCloseBtn.Width := 12;
  FCloseBtn.Height := 12;
  FCloseBtn.Glyph.LoadFromResourceName(HInstance, 'CLOSEBMP');;
  FCloseBtn.Margin := -1;
  FCloseBtn.Spacing := 0;
  FCloseBtn.OnClick := _CloseBtn;
  FCloseBtn.Visible := True;
  FUnlinkBtn.Top := 4;
  FUnlinkBtn.Left := Self.ClientWidth - 16 - FCloseBtn.Width;
  FUnlinkBtn.Width := 12;
  FUnlinkBtn.Height := 12;
  FUnlinkBtn.Glyph.LoadFromResourceName(HInstance, 'UNLINKBMP');;
  FUnlinkBtn.Margin := -1;
  FUnlinkBtn.Spacing := 0;
  FUnlinkBtn.OnClick := _UnlinkBtn;
  FUnlinkBtn.Visible := True;
  Visible := True;
  Result := True;
end;

procedure TOQBTable._CloseBtn(Sender: TObject);
begin
  TOQBArea(Parent).UnlinkTable(Self);
  TOQBForm_SQL(GetParentForm(Self)).QBGrid.RemoveColumn4Tbl(FTableName);
  Parent.RemoveControl(Self);
  Free;
end;

procedure TOQBTable._UnlinkBtn(Sender: TObject);
begin
  TOQBArea(Parent).UnlinkTable(Self);
end;

procedure TOQBTable._SelectAll(Sender: TObject);
var
  i: Integer;
begin
  if FLbx.Items.Count = 1 then
    Exit;
  if FLbx.Checked[0] then
    TOQBForm_SQL(GetParentForm(Self)).QBGrid.RemoveColumn4Tbl(FTableName);
  FLbx.Checked[0] := False;
  for i := 1 to (FLbx.Items.Count - 1) do
  begin
    FLbx.Checked[i] := True;
    TOQBForm_SQL(GetParentForm(Self)).QBGrid.Insert(
      TOQBForm_SQL(GetParentForm(Self)).QBGrid.ColCount,
      FLbx.Items[i], FTableName);
  end;
end;

procedure TOQBTable._UnSelectAll(Sender: TObject);
var
  i: Integer;
begin
  if FLbx.Items.Count = 1 then
    Exit;
  for i := 1 to (FLbx.Items.Count - 1) do
  begin
    FLbx.Checked[i] := False;
    TOQBForm_SQL(GetParentForm(Self)).QBGrid.RemoveColumn4Tbl(FTableName);
  end;
end;

procedure TOQBTable._DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if (Source is TCustomListBox) and (TWinControl(Source).Parent is TOQBTable) then
    Accept := True;
end;

procedure TOQBTable._DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  nRow: Integer;
  hRow: Integer;
begin
  if (Source is TCustomListBox) then
  begin
    if (TWinControl(Source).Parent is TOQBTable) then
    begin
      hRow := FLbx.ItemHeight;
      if hRow <> 0 then
        nRow := Y div hRow else
        nRow := 0;
      if nRow > FLbx.Items.Count - 1 then
        nRow := FLbx.Items.Count - 1;
      // handler for target's '*' row
      if nRow = 0 then
        Exit;
      // handler for source's '*' row
      if TOQBTable(TWinControl(Source).Parent).FLbx.ItemIndex = 0 then
        Exit;
      if Source <> FLbx then
        TOQBArea(Parent).InsertLink(
          TOQBTable(TWinControl(Source).Parent), Self,
          TOQBTable(TWinControl(Source).Parent).FLbx.ItemIndex, nRow)
      else if nRow <> FLbx.ItemIndex then
        TOQBArea(Parent).InsertLink(Self, Self, FLbx.ItemIndex, nRow);
    end
    else
      if Source = TOQBForm_SQL(GetParentForm(Self)).QBTables then
      begin
        X := X + Left + TWinControl(Sender).Left;
        Y := Y + Top + TWinControl(Sender).Top;
        TOQBArea(Parent).InsertTable(X, Y);
      end;
  end
end;

procedure TOQBTable.SetParent(AParent: TWinControl);
begin
  if (AParent <> nil) and (not (AParent is TScrollBox)) then
    raise Exception.Create(sNotValidTableParent);
  inherited;
end;

procedure TOQBTable.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  BringToFront;
  if (Button = mbLeft) then
  begin
    SetCapture(Self.Handle);
    ScreenDC := GetDC(0);

    ClipRect := Bounds(Parent.Left, Parent.Top, Parent.Width, Parent.Height);
    ClipRect.TopLeft := Parent.Parent.ClientToScreen(ClipRect.TopLeft);
    ClipRect.BottomRight := Parent.Parent.ClientToScreen(ClipRect.BottomRight);
    ClipRgn := CreateRectRgn(ClipRect.Left, ClipRect.Top, ClipRect.Right, ClipRect.Bottom);
    SelectClipRgn(ScreenDC, ClipRgn);
    ClipCursor(@ClipRect);
    OldX := X;
    OldY := Y;
    OldLeft := X;
    OldTop := Y;
    MoveRect := Rect(Self.Left, Self.Top, Self.Left + Self.Width, Self.Top + Self.Height);
    MoveRect.TopLeft := Parent.ClientToScreen(MoveRect.TopLeft);
    MoveRect.BottomRight := Parent.ClientToScreen(MoveRect.BottomRight);
    DrawFocusRect(ScreenDC, MoveRect);
    Moving := True;
  end;
end;

procedure TOQBTable.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Moving then
  begin
    DrawFocusRect(ScreenDC, MoveRect);
    OldX := X;
    OldY := Y;
    MoveRect := Rect(Self.Left + OldX - OldLeft, Self.Top + OldY - OldTop,
      Self.Left + Self.Width + OldX - OldLeft, Self.Top + Self.Height + OldY - OldTop);
    MoveRect.TopLeft := Parent.ClientToScreen(MoveRect.TopLeft);
    MoveRect.BottomRight := Parent.ClientToScreen(MoveRect.BottomRight);
    DrawFocusRect(ScreenDC, MoveRect);
  end;
end;

procedure TOQBTable.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    DrawFocusRect(ScreenDC, MoveRect);
    if (Self.Left <> Self.Left + X + OldLeft) or (Self.Top <> Self.Top + Y - OldTop) then
    begin
      Self.Visible := False;
      Self.Left := Self.Left + X - OldLeft;
      Self.Top := Self.Top + Y - OldTop;
      Self.Visible := True;
    end;
    ClipRect := Rect(0, 0, Screen.Width, Screen.Height);
    ClipCursor(@ClipRect);
    DeleteObject(ClipRgn);
    ReleaseDC(0, ScreenDC);
    Moving := False;
  end;

  TOQBArea(Parent).ReboundLinks4Table(Self);
end;

{ TOQBLink }

constructor TOQBLink.Create(AOwner: TComponent);
var
  mnuArr: array [1..4] of TMenuItem;
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 105;
  Height := 105;
  Rgn := CreateRectRgn(0, 0, Hand, Hand);
  mnuArr[1] := NewItem('', 0, False, False, nil, 0, 'mnuLinkName');
  mnuArr[2] := NewLine;
  mnuArr[3] := NewItem('Opções', 0, False, True, TOQBArea(AOwner).SetOptions, 0, 'mnuOptions');
  mnuArr[4] := NewItem('Remover', 0, False, True, TOQBArea(AOwner).Unlink, 0, 'mnuUnlink');
  PopMenu := NewPopupMenu(Self, 'mnu', paLeft, False, mnuArr);
  PopMenu.PopupComponent := Self;
end;

destructor TOQBLink.Destroy;
begin
  DeleteObject(Rgn);
  inherited;
end;

procedure TOQBLink.Paint;
var
  ArrRgn, pntArray: array [1..4] of TPoint;
  ArrCnt: Integer;
begin
  if tbl1 <> tbl2 then
  begin
    if ((LnkX = 1) and (LnkY = 1)) or ((LnkX = 4) and (LnkY = 2)) then
    begin
      pntArray[1].X := 0;
      pntArray[1].Y := Hand div 2;
      pntArray[2].X := Hand;
      pntArray[2].Y := Hand div 2;
      pntArray[3].X := Width - Hand;
      pntArray[3].Y := Height - Hand div 2;
      pntArray[4].X := Width;
      pntArray[4].Y := Height - Hand div 2;
      ArrRgn[1].X := pntArray[2].X + 5;
      ArrRgn[1].Y := pntArray[2].Y - 5;
      ArrRgn[2].X := pntArray[2].X - 5;
      ArrRgn[2].Y := pntArray[2].Y + 5;
      ArrRgn[3].X := pntArray[3].X - 5;
      ArrRgn[3].Y := pntArray[3].Y + 5;
      ArrRgn[4].X := pntArray[3].X + 5;
      ArrRgn[4].Y := pntArray[3].Y - 5;
    end;
    if Width > Hand + Hand2 then
    begin
      if ((LnkX = 2) and (LnkY = 1)) or ((LnkX = 3) and (LnkY = 2)) then
      begin
        pntArray[1].X := 0;
        pntArray[1].Y := Hand div 2;
        pntArray[2].X := Hand;
        pntArray[2].Y := Hand div 2;
        pntArray[3].X := Width - 5;
        pntArray[3].Y := Height - Hand div 2;
        pntArray[4].X := Width - Hand;
        pntArray[4].Y := Height - Hand div 2;
        ArrRgn[1].X := pntArray[2].X + 5;
        ArrRgn[1].Y := pntArray[2].Y - 5;
        ArrRgn[2].X := pntArray[2].X - 5;
        ArrRgn[2].Y := pntArray[2].Y + 5;
        ArrRgn[3].X := pntArray[3].X - 5;
        ArrRgn[3].Y := pntArray[3].Y + 5;
        ArrRgn[4].X := pntArray[3].X + 5;
        ArrRgn[4].Y := pntArray[3].Y - 5;
      end;
      if ((LnkX = 3) and (LnkY = 1)) or ((LnkX = 2) and (LnkY = 2)) then
      begin
        pntArray[1].X := Width - Hand;
        pntArray[1].Y := Hand div 2;
        pntArray[2].X := Width - 5;
        pntArray[2].Y := Hand div 2;
        pntArray[3].X := Hand;
        pntArray[3].Y := Height - Hand div 2;
        pntArray[4].X := 0;
        pntArray[4].Y := Height - Hand div 2;
        ArrRgn[1].X := pntArray[2].X - 5;
        ArrRgn[1].Y := pntArray[2].Y - 5;
        ArrRgn[2].X := pntArray[2].X + 5;
        ArrRgn[2].Y := pntArray[2].Y + 5;
        ArrRgn[3].X := pntArray[3].X + 5;
        ArrRgn[3].Y := pntArray[3].Y + 5;
        ArrRgn[4].X := pntArray[3].X - 5;
        ArrRgn[4].Y := pntArray[3].Y - 5;
      end;
    end
    else
    begin
      if ((LnkX = 2) and (LnkY = 1)) or ((LnkX = 3) and (LnkY = 2)) or
         ((LnkX = 3) and (LnkY = 1)) or ((LnkX = 2) and (LnkY = 2)) then
      begin
        pntArray[1].X := 0;
        pntArray[1].Y := Hand div 2;
        pntArray[2].X := Width - Hand2;
        pntArray[2].Y := Hand div 2;
        pntArray[3].X := Width - Hand2;
        pntArray[3].Y := Height - Hand div 2;
        pntArray[4].X := 0;
        pntArray[4].Y := Height - Hand div 2;
        ArrRgn[1].X := pntArray[2].X - 5;
        ArrRgn[1].Y := pntArray[2].Y - 5;
        ArrRgn[2].X := pntArray[2].X + 5;
        ArrRgn[2].Y := pntArray[2].Y + 5;
        ArrRgn[3].X := pntArray[3].X + 5;
        ArrRgn[3].Y := pntArray[3].Y + 5;
        ArrRgn[4].X := pntArray[3].X - 5;
        ArrRgn[4].Y := pntArray[3].Y - 5;
      end;
    end;
    if ((LnkX = 4) and (LnkY = 1)) or ((LnkX = 1) and (LnkY = 2)) then
    begin
      pntArray[1].X := Width;
      pntArray[1].Y := Hand div 2;
      pntArray[2].X := Width - Hand;
      pntArray[2].Y := Hand div 2;
      pntArray[3].X := Hand;
      pntArray[3].Y := Height - Hand div 2;
      pntArray[4].X := 0;
      pntArray[4].Y := Height - Hand div 2;
      ArrRgn[1].X := pntArray[2].X - 5;
      ArrRgn[1].Y := pntArray[2].Y - 5;
      ArrRgn[2].X := pntArray[2].X + 5;
      ArrRgn[2].Y := pntArray[2].Y + 5;
      ArrRgn[3].X := pntArray[3].X + 5;
      ArrRgn[3].Y := pntArray[3].Y + 5;
      ArrRgn[4].X := pntArray[3].X - 5;
      ArrRgn[4].Y := pntArray[3].Y - 5;
    end;
  end
  else
  begin
    pntArray[1].X := 0;
    pntArray[1].Y := Hand div 2;
    pntArray[2].X := Hand - 5;
    pntArray[2].Y := Hand div 2;
    pntArray[3].X := Hand - 5;
    pntArray[3].Y := Height - Hand div 2;
    pntArray[4].X := 0;
    pntArray[4].Y := Height - Hand div 2;
    ArrRgn[1].X := pntArray[2].X + 5;
    ArrRgn[1].Y := pntArray[2].Y - 5;
    ArrRgn[2].X := pntArray[2].X - 5;
    ArrRgn[2].Y := pntArray[2].Y + 5;
    ArrRgn[3].X := pntArray[3].X - 5;
    ArrRgn[3].Y := pntArray[3].Y + 5;
    ArrRgn[4].X := pntArray[3].X + 5;
    ArrRgn[4].Y := pntArray[3].Y - 5;
  end;

  Canvas.PolyLine(pntArray);
  Canvas.Brush := Parent.Brush;
  DeleteObject(Rgn);
  ArrCnt := 4;
  Rgn := CreatePolygonRgn(ArrRgn, ArrCnt, ALTERNATE);
end;

procedure TOQBLink._Click(X, Y: Integer);
var
  pnt: TPoint;
begin
  pnt.X := X;
  pnt.Y := Y;
  pnt := ClientToScreen(pnt);
  PopMenu.Popup(pnt.X, pnt.Y);
end;

procedure TOQBLink.CMHitTest(var Message: TCMHitTest);
begin
  if PtInRegion(Rgn, Message.XPos, Message.YPos) then
    Message.Result := 1;
end;

function TOQBLink.ControlAtPos(const Pos: TPoint): TControl;
var
  I: Integer;
  scrnP, P: TPoint;
begin
  scrnP := ClientToScreen(Pos);
  for I := Parent.ControlCount - 1 downto 0 do
  begin
    Result := Parent.Controls[I];
    if (Result is TOQBLink) and (Result <> Self) then
    with Result do
    begin
      P := Result.ScreenToClient(scrnP);
      if Perform(CM_HITTEST, 0, Integer(PointToSmallPoint(P))) <> 0 then
        Exit;
    end;
  end;
  Result := nil;
end;

procedure TOQBLink.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_RBUTTONDOWN) or (Message.Msg = WM_LBUTTONDOWN) then
    if not PtInRegion(Rgn, TWMMouse(Message).XPos, TWMMouse(Message).YPos) then
      ControlAtPos(SmallPointToPoint(TWMMouse(Message).Pos)) else
      _Click(TWMMouse(Message).XPos, TWMMouse(Message).YPos);
  inherited;
end;


{ TOQBArea }

procedure TOQBArea.CreateParams(var Params: TCreateParams);
begin
  inherited;
  OnDragOver := _DragOver;
  OnDragDrop := _DragDrop;
  Color      := clWindow;
end;

procedure TOQBArea.SetOptions(Sender: TObject);
var
  AForm: TOQBLinkForm;
  ALink: TOQBLink;
begin
  if TPopupMenu(Sender).Owner is TOQBLink then
  begin
    ALink := TOQBLink(TPopupMenu(Sender).Owner);
    AForm := TOQBLinkForm.Create(Application);
    AForm.txtTable1.Caption := ALink.tbl1.FTableName;
    AForm.txtCol1.Caption := ALink.fldNam1;
    AForm.txtTable2.Caption := ALink.tbl2.FTableName;
    AForm.txtCol2.Caption := ALink.fldNam2;
    AForm.RadioOpt.ItemIndex := ALink.FLinkOpt;
    AForm.RadioType.ItemIndex := ALink.FLinkType;
    if AForm.ShowModal = mrOk then
    begin
      ALink.FLinkOpt := AForm.RadioOpt.ItemIndex;
      ALink.FLinkType := AForm.RadioType.ItemIndex;
    end;
    AForm.Free;
  end;
end;

procedure TOQBArea.InsertTable(X, Y: Integer);
var
  NewTable: TOQBTable;
begin
  if FindTable(TOQBForm_SQL(GetParentForm(Self)).QBTables.Items[
    TOQBForm_SQL(GetParentForm(Self)).QBTables.ItemIndex]) <> nil then
  begin
    Mensagem('Tabela já inserida!', modInformacao, [modOk]);
    Exit;
  end;

  NewTable := TOQBTable.Create(Self);
  NewTable.Parent := Self;
  try
    NewTable.Activate(TOQBForm_SQL(GetParentForm(Self)).QBTables.Items[
      TOQBForm_SQL(GetParentForm(Self)).QBTables.ItemIndex], X, Y);
  except
    NewTable.Free;
  end;
end;

function TOQBArea.InsertLink(_tbl1, _tbl2: TOQBTable;
  _fldN1, _fldN2: Integer): TOQBLink;
begin
  Result := TOQBLink.Create(Self);
  with Result do
  begin
    Parent := Self;
    tbl1 := _tbl1;
    tbl2 := _tbl2;
    fldN1 := _fldN1;
    fldN2 := _fldN2;
    fldNam1 := tbl1.FLbx.Items[fldN1];
    fldNam2 := tbl2.FLbx.Items[fldN2];
  end;
  if FindLink(Result) then
  begin
    //ShowMessage('These tables are already linked.');
    Mensagem('Relacionamento já existente!', modInformacao, [modOk]);
    Result.Free;
    Result := nil;
    Exit;
  end;
  with Result do
  begin
    tbl1.FLbx.SelectItemBold(fldN1);
    tbl1.FLbx.Refresh;
    tbl2.FLbx.SelectItemBold(fldN2);
    tbl2.FLbx.Refresh;
    OnDragOver := _DragOver;
    OnDragDrop := _DragDrop;
  end;
  ReboundLink(Result);
  Result.Visible := True;
end;

function TOQBArea.FindTable(const TableName: string): TOQBTable;
var
  i: Integer;
  TempTable: TOQBTable;
begin
  Result := nil;
  for i := ControlCount - 1 downto 0 do
    if Controls[i] is TOQBTable then
    begin
      TempTable := TOQBTable(Controls[i]);
      if (TempTable.FTableName = TableName) then
      begin
        Result := TempTable;
        Exit;
      end;
    end;
end;

function TOQBArea.FindLink(Link: TOQBLink): Boolean;
var
  i: Integer;
  TempLink: TOQBLink;
begin
  Result := False;
  for i := ControlCount - 1 downto 0 do
    if Controls[i] is TOQBLink then
    begin
      TempLink := TOQBLink(Controls[i]);
      if (TempLink <> Link) then
        if (((TempLink.tbl1 = Link.tbl1) and (TempLink.fldN1 = Link.fldN1)) and
          ((TempLink.tbl2 = Link.tbl2) and (TempLink.fldN2 = Link.fldN2))) or
          (((TempLink.tbl1 = Link.tbl2) and (TempLink.fldN1 = Link.fldN2)) and
          ((TempLink.tbl2 = Link.tbl1) and (TempLink.fldN2 = Link.fldN1))) then
        begin
          Result := True;
          Exit;
        end;
    end;
end;

function TOQBArea.FindOtherLink(Link: TOQBLink; Tbl: TOQBTable;
  FldN: Integer): Boolean;
var
  i: Integer;
  OtherLink: TOQBLink;
begin
  Result := False;
  for i := ControlCount - 1 downto 0 do
    if Controls[i] is TOQBLink then
    begin
      OtherLink := TOQBLink(Controls[i]);
      if (OtherLink <> Link) then
        if ((OtherLink.tbl1 = Tbl) and (OtherLink.fldN1 = FldN)) or
           ((OtherLink.tbl2 = Tbl) and (OtherLink.fldN2 = FldN)) then
        begin
          Result := True;
          Exit;
        end;
    end;
end;

procedure TOQBArea.ReboundLink(Link: TOQBLink);
var
  X1, X2, Y1, Y2: Integer;
begin
  Link.PopMenu.Items[0].Caption := Link.tbl1.FTableName + ' :: ' +
    Link.tbl2.FTableName;
  Link.Hint := Link.PopMenu.Items[0].Caption;
  Link.ShowHint := True;
  with Link do
  begin
    if Tbl1 = Tbl2 then
    begin
      X1 := Tbl1.Left + Tbl1.Width;
      X2 := Tbl1.Left + Tbl1.Width + Hand;
    end
    else
    begin
      if Tbl1.Left < Tbl2.Left then
      begin
        if Tbl1.Left + Tbl1.Width + Hand < Tbl2.Left then
        begin    //A
          X1 := Tbl1.Left + Tbl1.Width;
          X2 := Tbl2.Left;
          LnkX := 1;
        end
        else
        begin    //B
          if Tbl1.Left + Tbl1.Width > Tbl2.Left + Tbl2.Width then
          begin
            X1 := Tbl2.Left + Tbl2.Width;
            X2 := Tbl1.Left + Tbl1.Width + Hand;
            LnkX := 3;
          end
          else
          begin
            X1 := Tbl1.Left + Tbl1.Width;
            X2 := Tbl2.Left + Tbl2.Width + Hand;
            LnkX := 2;
          end;
        end;
      end
      else
      begin
        if Tbl2.Left + Tbl2.Width + Hand > Tbl1.Left then
        begin    //C
          if Tbl2.Left + Tbl2.Width > Tbl1.Left + Tbl1.Width then
          begin
            X1 := Tbl1.Left + Tbl1.Width;
            X2 := Tbl2.Left + Tbl2.Width + Hand;
            LnkX := 2;
          end
          else
          begin
            X1 := Tbl2.Left + Tbl2.Width;
            X2 := Tbl1.Left + Tbl1.Width + Hand;
            LnkX := 3;
          end;
        end
        else
        begin    //D
          X1 := Tbl2.Left + Tbl2.Width;
          X2 := Tbl1.Left;
          LnkX := 4;
        end;
      end;
    end;

    Y1 := Tbl1.GetRowY(FldN1);
    Y2 := Tbl2.GetRowY(FldN2);
    if Y1 < Y2 then
    begin        //M
      Y1 := Tbl1.GetRowY(FldN1) - Hand div 2;
      Y2 := Tbl2.GetRowY(FldN2) + Hand div 2;
      LnkY := 1;
    end
    else
    begin         //N
      Y2 := Tbl1.GetRowY(FldN1) + Hand div 2;
      Y1 := Tbl2.GetRowY(FldN2) - Hand div 2;
      LnkY := 2;
    end;
    SetBounds(X1, Y1, X2 - X1, Y2 - Y1);
  end;
end;

procedure TOQBArea.ReboundLinks4Table(ATable: TOQBTable);
var
  i: Integer;
  Link: TOQBLink;
begin
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TOQBLink then
    begin
      Link := TOQBLink(Controls[i]);
      if (Link.Tbl1 = ATable) or (Link.Tbl2 = ATable) then
        ReboundLink(Link);
    end;
  end;
end;

procedure TOQBArea.Unlink(Sender: TObject);
var
  Link: TOQBLink;
begin
  if TPopupMenu(Sender).Owner is TOQBLink then
  begin
    Link := TOQBLink(TPopupMenu(Sender).Owner);
    RemoveControl(Link);

    if not FindOtherLink(Link, Link.tbl1, Link.fldN1) then
    begin
      Link.tbl1.FLbx.UnSelectItemBold(Link.fldN1);
      Link.tbl1.FLbx.Refresh;
    end;
    if not FindOtherLink(Link, Link.tbl2, Link.fldN2) then
    begin
      Link.tbl2.FLbx.UnSelectItemBold(Link.fldN2);
      Link.tbl2.FLbx.Refresh;
    end;

    Link.Free;
  end;
end;

procedure TOQBArea.UnlinkTable(ATable: TOQBTable);
var
  i: Integer;
  TempLink: TOQBLink;
begin
  for i := ControlCount - 1 downto 0 do
  begin
    if Controls[i] is TOQBLink then
    begin
      TempLink := TOQBLink(Controls[i]);

      if (TempLink.Tbl1 = ATable) or (TempLink.Tbl2 = ATable) then
      begin
        RemoveControl(TempLink);
        if not FindOtherLink(TempLink, TempLink.tbl1, TempLink.fldN1) then
        begin
          TempLink.tbl1.FLbx.UnSelectItemBold(TempLink.fldN1);
          TempLink.tbl1.FLbx.Refresh;
        end;
        if not FindOtherLink(TempLink, TempLink.tbl2, TempLink.fldN2) then
        begin
          TempLink.tbl2.FLbx.UnSelectItemBold(TempLink.fldN2);
          TempLink.tbl2.FLbx.Refresh;
        end;

        TempLink.Free;
      end;
    end;
  end;
end;

procedure TOQBArea._DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if (Source = TOQBForm_SQL(GetParentForm(Self)).QBTables) then
    Accept := True;
end;

procedure TOQBArea._DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if not (Sender is TOQBArea) then
  begin
    X := X + TControl(Sender).Left;
    Y := Y + TControl(Sender).Top;
  end;

  if Source = TOQBForm_SQL(GetParentForm(Self)).QBTables then
    InsertTable(X, Y);
end;


{ TOQBGrid }

procedure TOQBGrid.Inicializa;
begin
  ColCount := 2;
  RowCount := 6;
  Height := Parent.ClientHeight;
  DefaultRowHeight := Parent.Height div (6 + 1) - GridLineWidth;
  Cells[0, cFld] := 'Campo';
  Cells[0, cTbl] := 'Tabela';
  Cells[0, cShow] := 'Mostrar';
  Cells[0, cSort] := 'Ordem';
  Cells[0, cFunc] := 'Função';
  Cells[0, cGroup] := 'Grupo';
  IsEmpty := True;
end;

procedure TOQBGrid.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goColSizing, goColMoving];
  OnDragOver := _DragOver;
  OnDragDrop := _DragDrop;
end;

procedure TOQBGrid.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_RBUTTONDOWN) then
    ClickCell(TWMMouse(Message).XPos, TWMMouse(Message).YPos);
  inherited;
end;

function TOQBGrid.MaxSW(const s1, s2: string): Integer;
begin
  Result := Canvas.TextWidth(s1);
  if Result < Canvas.TextWidth(s2) then
    Result := Canvas.TextWidth(s2);
end;

procedure TOQBGrid.InsertDefault(aCol: Integer);
begin
  Cells[aCol, cShow] := sShow;
  Cells[aCol, cSort] := '';
  Cells[aCol, cFunc] := '';
  Cells[aCol, cGroup] := '';
end;

procedure TOQBGrid.Insert(aCol: Integer; const aField, aTable: string);
var
  i: Integer;
begin
  if IsEmpty then
  begin
    IsEmpty := False;
    aCol := 1;
    Cells[aCol, cFld] := aField;
    Cells[aCol, cTbl] := aTable;
    InsertDefault(aCol);
  end
  else
  begin
    if aCol = -1 then
    begin
      ColCount := ColCount + 1;
      aCol := ColCount - 1;
      Cells[aCol, cFld] := aField;
      Cells[aCol, cTbl] := aTable;
      InsertDefault(aCol);
    end
    else
    begin
      ColCount := ColCount + 1;
      for i := ColCount - 1 downto aCol + 1 do
        MoveColumn(i - 1, i);
      Cells[aCol, cFld] := aField;
      Cells[aCol, cTbl] := aTable;
      InsertDefault(aCol);
    end;
    //* Fix StringGrid Bug *
    if aCol > 1 then
      ColWidths[aCol - 1] := MaxSW(Cells[aCol - 1, cFld], Cells[aCol - 1, cTbl]) + 8;
    if aCol < ColCount - 1 then
      ColWidths[aCol + 1] := MaxSW(Cells[aCol + 1, cFld], Cells[aCol + 1, cTbl]) + 8;
    ColWidths[ColCount - 1] := MaxSW(Cells[ColCount - 1, cFld],
      Cells[ColCount - 1, cTbl]) + 8;
  end;

  if aCol < ColCount then
    ColWidths[aCol] := MaxSW(aTable, aField) + 8;
end;

function TOQBGrid.FindColumn(const sCol: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 1 to ColCount - 1 do
    if Cells[i, cFld] = sCol then
    begin
      Result := i;
      Exit;
    end;
end;

function TOQBGrid.FindSameColumn(aCol: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to ColCount - 1 do
    if i = aCol then
      Continue
    else if Cells[i, cFld] = Cells[aCol, cFld] then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TOQBGrid.RemoveColumn(aCol: Integer);
var
  i: Integer;
begin
  if (ColCount > 2) then
    DeleteColumn(aCol)
  else
  begin
    for i := 0 to RowCount - 1 do
      Cells[1, i] := '';
    IsEmpty := True;
  end;
end;

procedure TOQBGrid.RemoveColumn4Tbl(const Tbl: string);
var
  i: Integer;
begin
  for i := ColCount - 1 downto 1 do
    if Cells[i, cTbl] = Tbl then
      RemoveColumn(i);
end;

procedure TOQBGrid.ClickCell(X, Y: Integer);
var
  P: TPoint;
  mCol, mRow: Integer;
begin
  MouseToCell(X, Y, mCol, mRow);
  CurrCol := mCol;
  P.X := X;
  P.Y := Y;
  P := ClientToScreen(P);
  if (mCol > 0) and (mCol < ColCount) and (not IsEmpty) then
  begin
    if (Cells[mCol, 0] = '*') and (mRow <> cFld) then
      Exit;
    case mRow of
      cFld:
        TOQBForm_SQL(GetParentForm(Self)).mnuTbl.Popup(P.X, P.Y);
      cShow:
        begin
          TOQBForm_SQL(GetParentForm(Self)).mnuShow.Items[0].Checked := Cells[mCol, cShow] = sShow;
          TOQBForm_SQL(GetParentForm(Self)).mnuShow.Popup(P.X, P.Y);
        end;
      cSort:
        begin
          if Cells[mCol, cSort] = sSort[1] then
            TOQBForm_SQL(GetParentForm(Self)).mnuSort.Items[0].Checked := True
          else if Cells[mCol, cSort] = sSort[2] then
            TOQBForm_SQL(GetParentForm(Self)).mnuSort.Items[2].Checked := True else
            TOQBForm_SQL(GetParentForm(Self)).mnuSort.Items[3].Checked := True;
          TOQBForm_SQL(GetParentForm(Self)).mnuSort.Popup(P.X, P.Y);
        end;
      cFunc:
        begin
          if Cells[mCol, cFunc] = sFunc[1] then
            TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Items[0].Checked := True
          else if Cells[mCol, cFunc] = sFunc[2] then
            TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Items[2].Checked := True
          else if Cells[mCol, cFunc] = sFunc[3] then
            TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Items[3].Checked := True
          else if Cells[mCol, cFunc] = sFunc[4] then
            TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Items[4].Checked := True
          else if Cells[mCol, cFunc] = sFunc[5] then
            TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Items[5].Checked := True
          else
            TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Items[6].Checked := True;
          TOQBForm_SQL(GetParentForm(Self)).mnuFunc.Popup(P.X, P.Y);
        end;
      cGroup:
        begin
          TOQBForm_SQL(GetParentForm(Self)).mnuGroup.Items[0].Checked := Cells[mCol, cGroup] = sGroup;
          TOQBForm_SQL(GetParentForm(Self)).mnuGroup.Popup(P.X, P.Y);
        end;
    end;
  end;
end;

function TOQBGrid.SelectCell(ACol, ARow: Integer): Boolean;
begin
  inherited SelectCell(ACol, ARow);
  Result := ARow > cGroup;
end;

procedure TOQBGrid._DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if (Source <> TOQBForm_SQL(GetParentForm(Self)).QBTables) then
    Accept := True;
end;

procedure TOQBGrid._DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  dCol, dRow: Integer;
begin
  if ((Source is TOQBLbx) and
    (Source <> TOQBForm_SQL(GetParentForm(Self)).QBTables)) then
  begin
    TOQBTable(TWinControl(Source).Parent).FLbx.Checked[
      TOQBTable(TWinControl(Source).Parent).FLbx.ItemIndex] := True;//*** check
    MouseToCell(X, Y, dCol, dRow);
    if dCol = 0 then
      Exit;
    Insert(dCol,
      TOQBTable(TWinControl(Source).Parent).FLbx.Items[TOQBTable(TWinControl(Source).Parent).FLbx.ItemIndex],
      TOQBTable(TWinControl(Source).Parent).FTableName);
  end;
end;


{ TOQBForm }

procedure TOQBForm_SQL.CreateParams(var Params: TCreateParams);
begin
  inherited;
  QBArea := TOQBArea.Create(Self);
  QBArea.Parent := QBPanel;
  QBArea.Align := alClient;
  QBArea.Color := clGray;
  QBGrid := TOQBGrid.Create(Self);
  QBGrid.Parent := TabColumns;
  QBGrid.Align := alClient;
  VSplitter.Tag := VSplitter.Left;
  HSplitter.Tag := HSplitter.Top;
end;

procedure TOQBForm_SQL.mnuFunctionClick(Sender: TObject);
var
  Item: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    Item := (Sender as TMenuItem);
    if not Item.Checked then
    begin
      Item.Checked := True;
      QBGrid.Cells[QBGrid.CurrCol, cFunc] := sFunc[Item.Tag];
    end;
  end;
end;

procedure TOQBForm_SQL.mnuGroupClick(Sender: TObject);
begin
  if mnuGroup.Items[0].Checked then
  begin
    QBGrid.Cells[QBGrid.CurrCol, cGroup] := '';
    mnuGroup.Items[0].Checked := False;
  end
  else
  begin
    QBGrid.Cells[QBGrid.CurrCol, cGroup] := sGroup;
    mnuGroup.Items[0].Checked := True;
  end;
end;

procedure TOQBForm_SQL.mnuRemoveClick(Sender: TObject);
var
  TempTable: TOQBTable;
begin
  TempTable := QBArea.FindTable(QBGrid.Cells[QBGrid.CurrCol, cTbl]);
  if not QBGrid.FindSameColumn(QBGrid.CurrCol) then
    TempTable.FLbx.Checked[TempTable.FLbx.Items.IndexOf(QBGrid.Cells[QBGrid.CurrCol, cFld])] := False;
  QBGrid.RemoveColumn(QBGrid.CurrCol);
  QBGrid.Refresh; // fix for StringGrid bug
end;

procedure TOQBForm_SQL.mnuShowClick(Sender: TObject);
begin
  if mnuShow.Items[0].Checked then
  begin
    QBGrid.Cells[QBGrid.CurrCol, cShow] := '';
    mnuShow.Items[0].Checked := False;
  end
  else
  begin
    QBGrid.Cells[QBGrid.CurrCol, cShow] := sShow;
    mnuShow.Items[0].Checked := True;
  end;
end;

procedure TOQBForm_SQL.mnuSortClick(Sender: TObject);
var
  Item: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    Item := (Sender as TMenuItem);
    if not Item.Checked then
    begin
      Item.Checked := True;
      QBGrid.Cells[QBGrid.CurrCol, cSort] := sSort[Item.Tag];
    end;
  end;
end;

procedure TOQBForm_SQL.AtualizaLista_P;
var
  i: Integer;
  Lista: TStringList;
begin
  Lista_Parametros.ItemList.Clear;
  Lista_Parametros.InsertList.Clear;
  Lista_Parametros.ClearList;
  Lista := TStringList.Create;
  try
    for i:=0 to TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo.Count-1 do
    begin
      if Pos(';', TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I]) > 0 then
      begin
        StringToArray(TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I], ';', lista);
        if Trim(Lista[0]) <> '' then
        begin
          Lista_Parametros.ItemList.Add(Lista[1] +  ' '#9'' + ':' + Lista[0] +  ' '#9'' + '');
          Lista_Parametros.InsertList.Add(':' + Lista[0]);
        end;
      end;
    end;
  finally
    Lista.Free;
  end;
end;

procedure TOQBForm_SQL.ClearAll;
var
  i: Integer;
  TempTable: TOQBTable;
begin
  QBGrid.Inicializa;
  for i := QBArea.ControlCount - 1 downto 0 do
    if QBArea.Controls[i] is TOQBTable then
    begin
      TempTable := TOQBTable(QBArea.Controls[i]);
      QBGrid.RemoveColumn4Tbl(TempTable.FTableName);
      TempTable.Free;
    end
    else
      QBArea.Controls[i].Free; // QBLink

  AtualizaLista_P;
  
  MemoSQL.Lines.Clear;
  QBDialog.OQBEngine.ResultQuery.Close;
  QBDialog.OQBEngine.ClearQuerySQL;
  Pages.ActivePage := TabColumns;
end;

procedure TOQBForm_SQL.btnNewClick(Sender: TObject);
begin
  if Mensagem('Criar novo modelo?' + ^M + ^M + 'Atenção: Ao criar o novo modelo o atual será apagado!', modConfirmacao, [modSim, modNao]) = mrYes then
    ClearAll;
end;

procedure TOQBForm_SQL.btnOpenClick(Sender: TObject);
var
  i, ii, j: Integer;
  s, ss: string;
  TempDatabaseName: string;
  ShowSystemTables: Boolean;
  NewTable: TOQBTable;
  TableName: string;
  X, Y: Integer;
  NewLink: TOQBLink;
  Table1, Table2: TOQBTable;
  FieldN1, FieldN2: Integer;
  ColField, ColTable: string;
  StrList: TStringList;

  function GetNextVal(var s: string): string;
  var
    p: Integer;
    s1, s2: string;
  begin
    Result := EmptyStr;
    p := Pos(',', s);
    if p = 0 then
    begin
      p := Pos(';', s);
      if p = 0 then
         Exit;
    end;
    Result := System.Copy(s, 1, p - 1);
    System.Delete(s, 1, p);
    s1 := result;
    s2 := s;
  end;

begin
  j := -1;
  //if not DlgOpen.Execute then
  //  Exit;
  if Trim(QBDialog.SQL_Layout.Text) = '' then
    Exit;
  StrList := TStringList.Create;
  //StrList.LoadFromFile(DlgOpen.FileName);
  StrList.AddStrings(QBDialog.SQL_Layout);
  if StrList[0] <> QBSignature then
  begin
    //ShowMessage('File ' + DlgOpen.FileName + ' is not QBuilder''s query file.');
    StrList.Free;
    Exit;
  end;

  ClearAll;
  try
    s := StrList[3];  // read options
    if s = '+' then
      WindowState := wsMaximized
    else
    begin
      WindowState := wsNormal;
      Top := StrToInt(GetNextVal(s));
      Left := StrToInt(GetNextVal(s));
      Height := StrToInt(GetNextVal(s));
      Width := StrToInt(GetNextVal(s));
    end;

    s := StrList[4];
    btnTables.Down := Boolean(StrToInt(GetNextVal(s)));
    VSplitter.Visible := btnTables.Down;
    QBTables.Visible := btnTables.Down;
    QBTables.Width := StrToInt(GetNextVal(s));
    btnPages.Down := Boolean(StrToInt(GetNextVal(s)));
    HSplitter.Visible := btnPages.Down;
    Pages.Visible := btnPages.Down;
    Pages.Height := StrToInt(GetNextVal(s));

    s := StrList[6];  // read database
    TempDatabaseName := GetNextVal(s);
    ShowSystemTables := Boolean(StrToInt(GetNextVal(s)));

    QBDialog.OQBEngine.DatabaseName := TempDatabaseName;
    QBDialog.OQBEngine.ShowSystemTables := ShowSystemTables;
    OpenDatabase;

    for i := 8 to StrList.Count - 1 do  // read tables
    begin
      if StrList[i] = '[Links]' then
      begin
        j := i + 1;
        Break;
      end;
      s := StrList[i];
      TableName := GetNextVal(s);
      Y := StrToInt(GetNextVal(s));
      X := StrToInt(GetNextVal(s));
      NewTable := TOQBTable.Create(Self);
      NewTable.Parent := QBArea;
      try
        NewTable.Activate(TableName, X, Y);
        NewTable.FLbx.FLoading := True;
        for ii := 0 to NewTable.FLbx.Items.Count - 1 do
        begin
          ss := GetNextVal(s);
          if ss <> EmptyStr then
            NewTable.FLbx.Checked[ii] := Boolean(StrToInt(ss));
        end;
        NewTable.FLbx.FLoading := False;
      except
        NewTable.Free;
      end;
    end;

    if j <> -1 then
      for i := j to StrList.Count - 1 do  // read links
      begin
        if StrList[i] = '[Columns]' then
        begin
          j := i + 1;
          Break;
        end;
        s := StrList[i];
        ss := GetNextVal(s);
        Table1 := QBArea.FindTable(ss);
        ss := GetNextVal(s);
        FieldN1 := StrToInt(ss);
        ss := GetNextVal(s);
        Table2 := QBArea.FindTable(ss);
        ss := GetNextVal(s);
        FieldN2 := StrToInt(ss);
        NewLink := QBArea.InsertLink(Table1, Table2, FieldN1, FieldN2);
        ss := GetNextVal(s);
        NewLink.FLinkOpt := StrToInt(ss);
        ss := GetNextVal(s);
        NewLink.FLinkType := StrToInt(ss);
      end;

    if j <> -1 then
      for i := j to StrList.Count - 1 do  // read columns
      begin
        if StrList[i] = '[End]' then
          Break;
        s := StrList[i];
        ii := StrToInt(GetNextVal(s));
        ColField := GetNextVal(s);
        ColTable := GetNextVal(s);
        QBGrid.Insert(ii, ColField, ColTable);
        QBGrid.Cells[ii, cShow] := GetNextVal(s);
        QBGrid.Cells[ii, cSort] := GetNextVal(s);
        QBGrid.Cells[ii, cFunc] := GetNextVal(s);
        QBGrid.Cells[ii, cGroup] := GetNextVal(s);
      end;

      MemoSQL.Lines.Clear;
      MemoSQL.Lines.AddStrings(QBDialog.OQBEngine.SQL);
  finally
    StrList.Free;
  end;
end;

procedure TOQBForm_SQL.btnSaveClick(Sender: TObject);
var
  i, j: Integer;
  s: string;
  TempTable: TOQBTable;
  TempLink: TOQBLink;
  StrList: TStringList;
begin
  //if not DlgSave.Execute then Exit;
  StrList := TStringList.Create;
  StrList.Add(QBSignature);
  StrList.Add('');
  StrList.Add('[Options]');
  if WindowState = wsMaximized then
    s := '+' else
    s := IntToStr(Top) + ',' + IntToStr(Left) + ',' + IntToStr(Height) + ',' +
      IntToStr(Width) + ';';
  StrList.Add(s);
  s := IntToStr(Integer(btnTables.Down)) + ',' + IntToStr(QBTables.Width) +
    ',' + IntToStr(Integer(btnPages.Down)) + ',' + IntToStr(Pages.Height) + ';';
  StrList.Add(s);

  StrList.Add('[Database]');
  s := QBDialog.OQBEngine.DatabaseName + ',' + IntToStr(Integer(QBDialog.OQBEngine.ShowSystemTables)) + ';';
  StrList.Add(s);

  StrList.Add('[Tables]');  // save tables
  for i := 0 to QBArea.ControlCount - 1 do
    if QBArea.Controls[i] is TOQBTable then
    begin
      TempTable := TOQBTable(QBArea.Controls[i]);
      s := TempTable.FTableName + ',' +
        IntToStr(TempTable.Top + QBArea.VertScrollBar.ScrollPos) + ',' +
        IntToStr(TempTable.Left + QBArea.HorzScrollBar.ScrollPos);
      for j := 0 to TempTable.FLbx.Items.Count - 1 do
        if TempTable.FLbx.Checked[j] then
          s := s + ',1' else
          s := s + ',0';
      s := s + ';';
      StrList.Add(s);
    end;

  StrList.Add('[Links]');   // save links
  for i := 0 to QBArea.ControlCount - 1 do
    if QBArea.Controls[i] is TOQBLink then
    begin
      TempLink := TOQBLink(QBArea.Controls[i]);
      s := TempLink.Tbl1.FTableName + ',' + IntToStr(TempLink.FldN1) + ',' +
        TempLink.Tbl2.FTableName + ',' + IntToStr(TempLink.FldN2) + ',' +
        IntToStr(TempLink.FLinkOpt) + ',' + IntToStr(TempLink.FLinkType);
      s := s + ';';
      StrList.Add(s);
    end;

  StrList.Add('[Columns]');   // save columns
  if not QBGrid.IsEmpty then
    for i := 1 to QBGrid.ColCount - 1 do
    begin
      s := IntToStr(i) + ',' + QBGrid.Cells[i, cFld] + ',' + QBGrid.Cells[i, cTbl];
      s := s + ',' + QBGrid.Cells[i, cShow] + ',' + QBGrid.Cells[i, cSort] +
        ',' + QBGrid.Cells[i, cFunc] + ',' + QBGrid.Cells[i, cGroup];
      s := s + ';';
      StrList.Add(s);
    end;

  StrList.Add('[End]');   // end of QBuilder information

  //StrList.SaveToFile(DlgSave.FileName);
  QBDialog.SQL_Layout.Clear;
  QBDialog.SQL_Layout.AddStrings(StrList);
  StrList.Free;

  QBDialog.OQBEngine.SQL.Text := MemoSQL.Lines.Text;
end;

procedure TOQBForm_SQL.btnTablesClick(Sender: TObject);
begin
  VSplitter.Visible := TToolButton(Sender).Down;
  QBTables.Visible := TToolButton(Sender).Down;
  if not VSplitter.Visible then
    VSplitter.Tag := VSplitter.Left else
    VSplitter.Left := VSplitter.Tag;
end;

procedure TOQBForm_SQL.btnPagesClick(Sender: TObject);
begin
  HSplitter.Visible := TToolButton(Sender).Down;
  Pages.Visible := TToolButton(Sender).Down;
  if not HSplitter.Visible then
    HSplitter.Tag := HSplitter.Top else
    HSplitter.Top := HSplitter.Tag;
end;

procedure TOQBForm_SQL.OpenDatabase;
var
  I: Integer;
begin
  try
    QBDialog.OQBEngine.ReadTableList;
    QBDialog.OQBEngine.GenerateAliases;
    //QBTables.Items.Assign(QBDialog.OQBEngine.TableList);
    QBTables.Items.Clear;
    for I:=0 to FormDB_Case.Tree_Tabelas.Items.Count-1 do
      if (FormDB_Case.Tree_Tabelas.Items[I].Level = 0) and
         (FormDB_Case.Tree_Tabelas.Items[I].ImageIndex <> 7) then
        QBTables.Items.AddObject(FormDB_Case.Tree_Tabelas.Items[I].Text, FormDB_Case.Tree_Tabelas.Items[I].Data);
    ResDataSource.DataSet := QBDialog.OQBEngine.ResultQuery;
    Caption := sMainCaption;
  except
  end;
end;

procedure TOQBForm_SQL.SelectDatabase;
begin
  if QBDialog.OQBEngine.SelectDatabase then
  begin
    ClearAll;
    QBTables.Items.Clear;
    OpenDatabase;
  end
end;

procedure TOQBForm_SQL.btnDBClick(Sender: TObject);
begin
  SelectDatabase;
end;

procedure TOQBForm_SQL.btnSQLClick(Sender: TObject);
var
  Lst, Lst1, Lst2: TStringList;   // temporary string lists
  i: Integer;
  s: string;
  tbl1, tbl2: string;
  Link: TOQBLink;

  function ExtractName(s: string):string;
  var
    p: Integer;
  begin
    Result := s;
    p := Pos('.', s);
    if p = 0 then
      Exit;
    Result := System.Copy(s, 1, p - 1);
  end;

begin
  if QBGrid.IsEmpty then
  begin
    Mensagem('Selecione as colunas em tabelas!', modAdvertencia, [modOk]);
    Exit;
  end;
  Lst := TStringList.Create;

  with QBDialog.OQBEngine do
  begin
    SQLcolumns.Clear;
    SQLcolumns_func.Clear;
    SQLcolumns_table.Clear;
    SQLfrom.Clear;
    SQLwhere.Clear;
    SQLgroupby.Clear;
    SQLorderby.Clear;
  end;

//  SELECT clause
  with QBGrid do
  begin
    for i := 1 to ColCount - 1 do
      if Cells[i, cShow] = sShow then
      begin
        if QBDialog.OQBEngine.UseTableAliases then
          tbl1 := QBDialog.OQBEngine.AliasList[QBDialog.OQBEngine.TableList.IndexOf(Cells[i, cTbl])]
        else
          tbl1 := Cells[i, cTbl];
        s := tbl1 + '.' + Cells[i, cFld];
        Lst.Add(LowerCase(s));
        if Cells[i, cFunc] <> EmptyStr then
          s := UpperCase(Cells[i, cFunc]) else
          s := EmptyStr;
        if QBDialog.OQBEngine.UseTableAliases then
          QBDialog.OQBEngine.SQLcolumns_table.Add(LowerCase(
            QBDialog.OQBEngine.AliasList[QBDialog.OQBEngine.TableList.IndexOf(Cells[i, cTbl])]))
        else
          QBDialog.OQBEngine.SQLcolumns_table.Add(LowerCase(Cells[i, cTbl]));
        QBDialog.OQBEngine.SQLcolumns_func.Add(s);
      end;

    if Lst.Count = 0 then
    begin
      Mensagem('Colunas não selecionadas!!', modAdvertencia, [modOk]);
      Lst.Free;
      Exit;
    end;
    QBDialog.OQBEngine.SQLcolumns.Assign(Lst);
    Lst.Clear;
  end;

//  FROM clause
  with QBArea do
  begin
    Lst1 := TSTringList.Create;  // tables in joins
    Lst2 := TSTringList.Create;  // outer joins
    for i := 0 to ControlCount - 1 do  // search tables for joins
      if Controls[i] is TOQBLink then
      begin
        Link := TOQBLink(Controls[i]);
        if Link.FLinkType > 0 then
        begin
          if QBDialog.OQBEngine.UseTableAliases then
          begin
            tbl1 := LowerCase(Link.Tbl1.FTableAlias);
            tbl2 := LowerCase(Link.Tbl2.FTableAlias);
          end
          else
          begin
            tbl1 := LowerCase(Link.Tbl1.FTableName);
            tbl2 := LowerCase(Link.Tbl2.FTableName);
          end;
          if Lst1.IndexOf(tbl1) = -1 then
            Lst1.Add(tbl1);
          if Lst1.IndexOf(tbl2) = -1 then
            Lst1.Add(tbl2);
          if QBDialog.OQBEngine.UseTableAliases then
            Lst2.Add(LowerCase(Link.Tbl1.FTableName) + ' ' + tbl1 +
              sOuterJoin[Link.FLinkType] +
              LowerCase(Link.Tbl2.FTableName) + ' ' + tbl2 + ' ON ' +
              tbl1 + '.' + LowerCase(Link.FldNam1) + sLinkOpt[Link.FLinkOpt] +
              tbl2 + '.' + LowerCase(Link.FldNam2))
          else
            Lst2.Add(tbl1 + sOuterJoin[Link.FLinkType] + tbl2 + ' ON ' +
              tbl1 + '.' + LowerCase(Link.FldNam1) +
              sLinkOpt[Link.FLinkOpt] + tbl2 + '.' + LowerCase(Link.FldNam2));
        end;
      end;

    for i := 0 to ControlCount - 1 do
      if Controls[i] is TOQBTable then
      begin
        if QBDialog.OQBEngine.UseTableAliases then
          tbl1 := LowerCase(TOQBTable(Controls[i]).FTableAlias) else
          tbl1 := LowerCase(TOQBTable(Controls[i]).FTableName);
        if (Lst.IndexOf(tbl1) = -1) and (Lst1.IndexOf(tbl1) = -1) then
          if QBDialog.OQBEngine.UseTableAliases then
            Lst.Add(LowerCase(TOQBTable(Controls[i]).FTableName) + ' ' + tbl1) else
            Lst.Add(tbl1);
      end;

    Lst1.Free;

    QBDialog.OQBEngine.SQLfrom.Assign(Lst2);
    QBDialog.OQBEngine.SQLfrom.AddStrings(Lst);
    Lst2.Free;
    Lst.Clear;
  end;

//  WHERE clause
  with QBArea do
  begin
    for i := 0 to ControlCount - 1 do
      if Controls[i] is TOQBLink then
      begin
        Link := TOQBLink(Controls[i]);
        if Link.FLinkType = 0 then
        begin
          if QBDialog.OQBEngine.UseTableAliases then
            s := Link.tbl1.FTableAlias + '.' + Link.fldNam1 + sLinkOpt[Link.FLinkOpt] +
              Link.tbl2.FTableAlias + '.' + Link.fldNam2
          else
            s := Link.tbl1.FTableName + '.' + Link.fldNam1 + sLinkOpt[Link.FLinkOpt] +
              Link.tbl2.FTableName + '.' + Link.fldNam2;

          Lst.Add(LowerCase(s));
        end;
      end;
    QBDialog.OQBEngine.SQLwhere.Assign(Lst);
    Lst.Clear;
  end;

// GROUP BY clause
  with QBGrid do
  begin
    for i := 1 to ColCount - 1 do
    begin
      if Cells[i, cGroup] <> EmptyStr then
      begin
        if QBDialog.OQBEngine.UseTableAliases then
          tbl1 := QBDialog.OQBEngine.AliasList[QBDialog.OQBEngine.TableList.IndexOf(Cells[i, cTbl])]
        else
          tbl1 := Cells[i, cTbl];
        s := tbl1 + '.' + Cells[i, cFld];
        Lst.Add(LowerCase(s));
      end;
    end;
    QBDialog.OQBEngine.SQLgroupby.Assign(Lst);
    Lst.Clear;
  end;

// ORDER BY clause
  with QBGrid do
  begin
    for i := 1 to ColCount - 1 do
    begin
      if Cells[i, cSort] <> EmptyStr then
      begin
        if QBDialog.OQBEngine.UseTableAliases then
          tbl1 := QBDialog.OQBEngine.AliasList[QBDialog.OQBEngine.TableList.IndexOf(Cells[i, cTbl])]
        else
          tbl1 := Cells[i, cTbl];
        // --- to order result set by the result of an aggregate function
        if Cells[i, cFunc] = EmptyStr then
          s := LowerCase(tbl1 + '.' + Cells[i, cFld]) else
          s := IntToStr(i);
        // ---

        if Cells[i, cSort] = sSort[3] then
          s := s + ' DESC';
        Lst.Add(s);
      end;
    end;
    QBDialog.OQBEngine.SQLorderby.Assign(Lst);
    Lst.Clear;
  end;

  MemoSQL.Lines.Text := QBDialog.OQBEngine.GenerateSQL;
  Pages.ActivePage := TabSQL;
  Lst.Free;
end;

procedure TOQBForm_SQL.btnResultsClick(Sender: TObject);
var
  I: Integer;
  Lista: TStringList;
  Valor, Mascara: String;
begin
  //QBDialog.OQBEngine.CloseResultQuery; // OQB 4.0a
  //QBDialog.OQBEngine.SetQuerySQL(MemoSQL.Lines.Text);
  //QBDialog.OQBEngine.OpenResultQuery;
  if Trim(MemoSQL.Lines.Text) = '' then
  begin
    Mensagem('Expressão SQL não gerada!', modAdvertencia, [modOk]);
    exit;
  end;
  try
    TabGlobal_i.DBDADOS.First;
    if not TabGlobal_i.DBDADOS.Locate('NUMERO', TabGlobal_i.DCONSULTA.BASE.Conteudo, []) then
    begin
      Mensagem('Banco de dados não definido na consulta!', modAdvertencia, [modOk]);
      exit;
    end
    else
    begin
      SDQuery.Active       := False;
      SDDatabase.Connected := False;
      ChDir(Projeto.Pasta);
      if Trim(TabGlobal_i.DBDADOS.HOST_NAME.Conteudo) <> '' then
        SDDatabase.RemoteDatabase := TabGlobal_i.DBDADOS.HOST_NAME.Conteudo + ':' + TabGlobal_i.DBDADOS.ARQUIVO.Conteudo
      else
        SDDatabase.RemoteDatabase := TabGlobal_i.DBDADOS.ARQUIVO.Conteudo;
      case TabGlobal_i.DBDADOS.BDADOS.Conteudo of
        1: begin
             SDDatabase.ServerType := stInterbase;
             if Pos('.', SDDatabase.RemoteDatabase) < 1 then
               SDDatabase.RemoteDatabase := SDDatabase.RemoteDatabase + '.gdb';
           end;
        2: begin
             SDDatabase.ServerType := stFirebird;
             if Pos('.', SDDatabase.RemoteDatabase) < 1 then
               SDDatabase.RemoteDatabase := SDDatabase.RemoteDatabase + '.gdb';
           end;
        3: SDDatabase.ServerType := stSQLBase;
        4: SDDatabase.ServerType := stOracle;
        5: SDDatabase.ServerType := stSQLServer;
        6: SDDatabase.ServerType := stSybase;
        7: SDDatabase.ServerType := stDB2;
        8: SDDatabase.ServerType := stInformix;
        9: SDDatabase.ServerType := stODBC;
        10: SDDatabase.ServerType := stMySQL;
        11: SDDatabase.ServerType := stPostgreSQL;
        12: SDDatabase.ServerType := stOLEDB;
      end;
      SDDatabase.Params.Clear;
      SDDatabase.Params.Add('USER NAME='+TabGlobal_i.DBDADOS.USUARIO.Conteudo);
      SDDatabase.Params.Add('PASSWORD='+TabGlobal_i.DBDADOS.SENHA.Conteudo);
      if TabGlobal_i.DBDADOS.BDADOS.Conteudo < 3 then
        SDDatabase.Params.Add('SQL DIALECT=3');
      SDDatabase.LoginPrompt := False;
      SDDatabase.Connected := True;
      if SDDatabase.Connected then
      begin
        SDQuery.SQL.Text := MemoSQL.Lines.Text;
        ResDataSource.DataSet := SDQuery;
        Lista := TStringList.Create;
        for I:=0 to TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo.Count -1 do
        begin
          if Pos(';', TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I]) > 0 then
          begin
            StringToArray(TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I], ';', lista);
            if Trim(Lista[0]) <> '' then
            begin
              if SDQuery.Params.FindParam(Lista[0]) <> Nil then
              begin
                SDQuery.Params.FindParam(Lista[0]).DataType := R_DataType(Lista[1]);
                InputQuery(Lista[0], 'Informe o valor ' + Lista[0], Valor);
                if Trim(Valor) <> '' then
                  SDQuery.Params.FindParam(Lista[0]).Value := Valor;
              end;
            end;
          end;
        end;
        Lista.Free;
        SDQuery.Prepare;
        SDQuery.Open;
        if Trim(TabGlobal_i.DCONSULTA.TITULOS.Conteudo.Text) <> '' then
          for I:=0 to SDQuery.Fields.Count-1 do
            SDQuery.Fields[I].Visible := False;
        Lista := TStringList.Create;
        for I:=0 to TabGlobal_i.DCONSULTA.TITULOS.Conteudo.Count-1 do
        begin
          StringToArray(TabGlobal_i.DCONSULTA.TITULOS.Conteudo[I], ';', Lista);
          if Lista.Count > 1 then
          begin
            Mascara := Lista[1];
            if Trim(Mascara) <> '' then
              if TrimRight(Mascara[Length(TrimRight(Mascara))]) = '*' then
                Mascara := '';
            if I <= SDQuery.Fields.Count-1 then
              ConfiguraMascaraCampo(SDQuery.Fields[I], Lista[0], Mascara, I, StrToIntDef(Lista[2], 0), True);
          end;
        end;
        Lista.Free;
      end;
    end;
  except
    on Erro: Exception do
    begin
      Screen.Cursor := crDefault;
      Mensagem('Erro de conexão: '+Erro.Message, modErro, [modOk]);
    end;
  end;
  Pages.ActivePage := TabResults;
end;

procedure TOQBForm_SQL.btnSaveResultsClick(Sender: TObject);
begin
  QBDialog.OQBEngine.SaveResultQueryData;
end;

procedure TOQBForm_SQL.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TOQBForm_SQL.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TOQBForm_SQL.QBTablesDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 20;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    Canvas.BrushCopy(r, Image1.Picture.Bitmap, Rect(0, 0, 18, 20),
      Image1.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 25, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TOQBForm_SQL.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SDQuery.Active := False;
  SDDatabase.Connected := False;
  btnSaveClick(Self);
end;

procedure TOQBForm_SQL.BtnParametrosClick(Sender: TObject);
begin
  FormParametros := TFormParametros.Create(Application);
  try
    FormParametros.Tabela := True;
    FormParametros.Lista_Parametros.AddStrings(TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo);
    if FormParametros.ShowModal = mrOk then
    begin
      TabGlobal_i.DCONSULTA.Modifica;
      TBlobField(TabGlobal_i.DCONSULTA.FieldByName('PARAMETROS')).AsString := FormParametros.Lista_Parametros.Text;
      TabGlobal_i.DCONSULTA.Salva;
      AtualizaLista_P;
    end;
  finally
    FormParametros.Free;
  end;
end;

procedure TOQBForm_SQL.BtnTitulosClick(Sender: TObject);
begin
  FormTitulos := TFormTitulos.Create(Application);
  try
    FormTitulos.Lista_Parametros.AddStrings(TabGlobal_i.DCONSULTA.TITULOS.Conteudo);
    if FormTitulos.ShowModal = mrOk then
    begin
      TabGlobal_i.DCONSULTA.Modifica;
      TBlobField(TabGlobal_i.DCONSULTA.FieldByName('TITULOS')).AsString := FormTitulos.Lista_Parametros.Text;
      TabGlobal_i.DCONSULTA.Salva;
    end;
  finally
    FormTitulos.Free;
  end;
end;

end.
