unit TreeEdit;

interface

uses
  SysUtils, Classes, Dialogs, StdCtrls, Controls, ComCtrls, Forms;

type
  TFormTreeEdit = class(TForm)
    GroupBox1: TGroupBox;
    PropGroupBox: TGroupBox;
    New: TButton;
    Delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    TreeView: TTreeView;
    NewSub: TButton;
    Text: TEdit;
    Image: TEdit;
    Button4: TButton;
    Cancel: TButton;
    Apply: TButton;
    SelectedIndex: TEdit;
    Label4: TLabel;
    Load: TButton;
    OpenDialog1: TOpenDialog;
    procedure NewClick(Sender: TObject);
    procedure NewSubClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure TextExit(Sender: TObject);
    procedure ImageExit(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure SelectedIndexExit(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: WideString);
  private
    FItems: TTreeNodes;
    FDropping: Boolean;
    procedure FlushControls;
    procedure SetItem(Value: TTreeNode);
    procedure SetStates;
  public
    property Items: TTreeNodes read FItems;
  end;

function EditTreeViewItems(AItems: TTreeNodes): Boolean;

implementation

{$R *.dfm}

function EditTreeViewItems(AItems: TTreeNodes): Boolean;
begin
  with TFormTreeEdit.Create(Application) do
    try
      TreeView.SortType := TTreeView(AItems.Owner).SortType;
      FItems := AItems;
      TreeView.Items.Assign(Items);
      with TreeView do
        if Items.Count > 0 then
        begin
          Selected := Items.GetFirstNode;
          TreeViewChange(nil, Selected);
        end;
      SetStates;
      Apply.Enabled := False;
      Result := ShowModal = mrOK;
      if Result and Apply.Enabled then
        ApplyClick(nil);
    finally
      Free;
    end;
end;

procedure ConvertError(Value: TEdit);
begin
  with Value do
  begin
    SetFocus;
    SelectAll;
  end;
end;

{ TFormTreeEdit }

procedure TFormTreeEdit.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  PropGroupBox.Enabled := Delete.Enabled;
  NewSub.Enabled := TreeView.Selected <> nil;
end;

procedure TFormTreeEdit.SetItem(Value: TTreeNode);
begin
  if Assigned(Value) then
    with Value do
    begin
      Self.Text.Text := Text;
      Image.Text := IntToStr(ImageIndex);
      Self.SelectedIndex.Text := IntToStr(SelectedIndex);
    end
  else
  begin
    Text.Text := '';
    Image.Text := '';
    SelectedIndex.Text := '';
  end;
  SetStates;
end;

procedure TFormTreeEdit.FlushControls;
begin
  TextExit(nil);
  ImageExit(nil);
  SelectedIndexExit(nil);
end;

procedure TFormTreeEdit.TreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if not FDropping then
    FlushControls;
end;

procedure TFormTreeEdit.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  TempEnabled: Boolean;
begin
  if not FDropping then
  begin
    TempEnabled := Apply.Enabled;
    SetStates;
    SetItem(Node);
    Apply.Enabled := TempEnabled;
  end;
end;

procedure TFormTreeEdit.NewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  Node := TreeView.Items.Add(Node, '');
  Node.MakeVisible;
  TreeView.Selected := Node;
  SetItem(Node);
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TFormTreeEdit.NewSubClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  with TreeView do
  begin
    Node := Selected;
    if Assigned(Node) then
    begin
      Node := Items.AddChild(Node, '');
      Node.MakeVisible;
      Selected := Node;
    end;
  end;
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TFormTreeEdit.DeleteClick(Sender: TObject);
begin
  TreeView.Selected.Free;
  if TreeView.Items.Count = 0 then
    SetItem(nil)
  else if Assigned(TreeView.Selected) then
    SetItem(TreeView.Selected);
  SetStates;
  Apply.Enabled := True;
end;

procedure TFormTreeEdit.ValueChange(Sender: TObject);
begin
  Apply.Enabled := True;
  if Sender = Text then
    TextExit(Sender);
end;

procedure TFormTreeEdit.TextExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Assigned(Node) then
    Node.Text := Text.Text;
end;

procedure TFormTreeEdit.ImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if Assigned(Node) then
        Node.ImageIndex := StrToInt(Image.Text);
    except
      ConvertError(Image);
      raise;
    end;
end;

procedure TFormTreeEdit.SelectedIndexExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if not Assigned(Node) then
        Exit;
      Node.SelectedIndex := StrToInt(SelectedIndex.Text);
    except
      ConvertError(SelectedIndex);
      raise;
    end;
end;

procedure TFormTreeEdit.ApplyClick(Sender: TObject);
begin
  FlushControls;
  Items.Assign(TreeView.Items);
  Apply.Enabled := False;
end;

procedure TFormTreeEdit.LoadClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Abrir...';
  with OpenDialog1 do
    if Execute then
    begin
      TreeView.LoadFromFile(FileName);
      SetStates;
      Apply.Enabled := True;
    end;
end;

procedure TFormTreeEdit.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TFormTreeEdit.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node: TTreeNode;
  AddMode: TNodeAttachMode;
begin
  FDropping := True;
  try
    with TreeView do
      if Assigned(Selected) then
      begin
        //if ssCtrl in Application.KeyState then
        //  AddMode := naAddChildFirst
        //else
          AddMode := naInsert;
        Node := TreeView.DropTarget;
        if Assigned(Node) then
          Selected.MoveTo(Node, AddMode);
        Apply.Enabled := True;
  {      if Node = nil then
        begin
          Node := Items[Items.Count - 1];
          while Assigned(Node) and not Node.IsVisible do
            Node := Node.GetPrev;
        end;
        if Assigned(Node) then
          with Selected do
          try
            FDropping := True;
            MoveTo(Node, AddMode);
            Selected := True;
            Apply.Enabled := True;
          finally
            FDropping := False;
          end; }
      end;
  finally
    FDropping := False;
  end;
end;

procedure TFormTreeEdit.TreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: WideString);
begin
  Text.Text := S;
  TextExit(nil);
end;

end.
