unit MenuEdit;

interface

uses
  SysUtils, Classes, Dialogs, StdCtrls, Controls, ComCtrls, Forms,
  menus, Windows, TypInfo;

type
  TFormMenuEdit_i = class(TForm)
    GroupBox1: TGroupBox;
    New: TButton;
    Delete: TButton;
    TreeView: TTreeView;
    NewSub: TButton;
    procedure NewClick(Sender: TObject);
    procedure NewSubClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FItems: TTreeNodes;
    FDropping: Boolean;
    procedure SetItem(Value: TTreeNode);
    procedure SetStates;
  public
    fecha: Boolean;
    MItems: TMenuItem;
    property Items: TTreeNodes read FItems;
  end;

var
  FormMenuEdit_i: TFormMenuEdit_i;

implementation

uses ObjInsp, Rotinas, FDesigner;

{$R *.dfm}

procedure ConvertError(Value: TEdit);
begin
  with Value do
  begin
    SetFocus;
    SelectAll;
  end;
end;

{ TFormTreeEdit }

procedure TFormMenuEdit_i.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  NewSub.Enabled := TreeView.Selected <> nil;
end;

procedure TFormMenuEdit_i.SetItem(Value: TTreeNode);
begin
  if Assigned(Value) then
    with Value do
    begin
      FormObjInsp.Atribui(Value.Data, True);
    end
  else
    FormObjInsp.Atribui(Nil, True);
  SetStates;
end;

procedure TFormMenuEdit_i.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  if not FDropping then
  begin
    SetStates;
    SetItem(Node);
  end;
end;

procedure TFormMenuEdit_i.NewClick(Sender: TObject);
var
  Node: TTreeNode;
  mnuItem: TMenuItem;
begin
  if Assigned(TreeView.Selected) then
    Node := TreeView.Selected;
  mnuItem := FormDesigner_Net.CurrentForm_Avulso.NovoItemMenu;
  if Assigned(TreeView.Selected) then
  begin
    TMenuItem(Node.Data).Parent.Add(mnuItem);
    Node := TreeView.Items.AddObject(Node, mnuItem.Caption, mnuItem);
  end
  else
  begin
    MItems.Add(mnuItem);
    Node := TreeView.Items.AddObject(Nil, mnuItem.Caption, mnuItem);
  end;
  FormDesigner_Net.CurrentForm_Avulso.Atualiza_CB(False, mnuItem.Name, mnuItem.ClassName, mnuItem);
  Node.MakeVisible;
  TreeView.Selected := Node;
  SetItem(Node);
  FormObjInsp.Show;
end;

procedure TFormMenuEdit_i.NewSubClick(Sender: TObject);
var
  Node: TTreeNode;
  mnuItem: TMenuItem;
begin
  with TreeView do
  begin
    Node := Selected;
    if Assigned(Node) then
    begin
      mnuItem := FormDesigner_Net.CurrentForm_Avulso.NovoItemMenu;
      TMenuItem(Node.Data).Add(mnuItem);
      Node := Items.AddChildObject(Node, mnuItem.Caption, mnuItem);
      FormDesigner_Net.CurrentForm_Avulso.Atualiza_CB(False, mnuItem.Name, mnuItem.ClassName, mnuItem);
      Node.MakeVisible;
      Selected := Node;
    end;
  end;
  FormObjInsp.Show;
end;

procedure TFormMenuEdit_i.DeleteClick(Sender: TObject);
begin
  if Mensagem('Excluir '+TreeView.Selected.Text+' ?', ModConfirmacao,[ModSim, ModNao]) = mrYes then
  begin
    TComponent(TreeView.Selected.Data).Free;
    FormDesigner_Net.CurrentEdit.Modified := True;
    FormDesigner_Net.CurrentForm_Avulso.Atualiza_CB(True, '', '', Nil);
    TreeView.Selected.Free;
    if TreeView.Items.Count = 0 then
      SetItem(nil)
    else if Assigned(TreeView.Selected) then
      SetItem(TreeView.Selected);
    SetStates;
 end;
end;

procedure TFormMenuEdit_i.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TFormMenuEdit_i.TreeViewDragDrop(Sender, Source: TObject; X,
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

procedure TFormMenuEdit_i.FormClose(Sender: TObject;
  var Action: TCloseAction);
{var
  T_Items: TMenuItem;
  I, T: Integer;
  Item: TMenuItem;
  PropItems: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
  Nome: String;

  function AtribuiProp(O_Item, D_Item: TMenuItem): String;
  var
    Nome: String;
  begin
    D_Item.Action             := O_Item.Action;
    D_Item.AutoHotkeys        := O_Item.AutoHotkeys;
    D_Item.AutoLineReduction  := O_Item.AutoLineReduction;
    D_Item.Bitmap             := O_Item.Bitmap;
    D_Item.Break              := O_Item.Break;
    D_Item.Caption            := O_Item.Caption;
    D_Item.Checked            := O_Item.Checked;
    D_Item.Default            := O_Item.Default;
    D_Item.Enabled            := O_Item.Enabled;
    D_Item.GroupIndex         := O_Item.GroupIndex;
    D_Item.HelpContext        := O_Item.HelpContext;
    D_Item.Hint               := O_Item.Hint;
    D_Item.ImageIndex         := O_Item.ImageIndex;
    D_Item.RadioItem          := O_Item.RadioItem;
    D_Item.ShortCut           := O_Item.ShortCut;
    D_Item.SubMenuImages      := O_Item.SubMenuImages;
    D_Item.Tag                := O_Item.Tag;
    D_Item.Visible            := O_Item.Visible;
    Result := O_Item.Name;
  end;

  procedure SubTreeView(SubTree: TTreeNode);
  var
    Y: Integer;
    SItem: TMenuItem;
    SNome: String;
  begin
    for Y:=0 to SubTree.Count-1 do
    begin
      SItem := FormDesigner_Net.CurrentForm_Avulso.NovoItemMenu;
      SNome := AtribuiProp(TMenuItem(SubTree[Y].Data), SItem);
      T_Items.Add(SItem);
      if SubTree[Y].Count > 0 then
        SubTreeView(SubTree[Y]);
      TMenuItem(SubTree[Y].Data).Free;
      SItem.Name := SNome;
    end;
  end;}

begin
  if not fecha then
  begin
    {FormObjInsp.Atribui(Nil, True);
    if Assigned(MItems) then
    begin
      //T_Items := TMenuItem.Create(Self);
      T_Items := FormDesigner_Net.CurrentForm_Avulso.NovoItemMenu;
      for I:=0 to TreeView.Items.Count-1 do
      begin
        Item := FormDesigner_Net.CurrentForm_Avulso.NovoItemMenu;
        Nome := AtribuiProp(TMenuItem(TreeView.Items[I].Data), Item);
        T_Items.Add(Item);
        if TreeView.Items[I].Count > 0 then
          SubTreeView(TreeView.Items[I]);
        TMenuItem(TreeView.Items[I].Data).Free;
        Item.Name := Nome;
      end;
    end;
    FormDesigner_Net.CurrentForm_Avulso.RedefineMenu(T_Items);
    //T_Items.Free;}
    Action := caNone;
    Hide;
  end
end;

procedure TFormMenuEdit_i.FormShow(Sender: TObject);
var
  I: Integer;
  NewNode: TTreeNode;

  procedure SubNivel(Sub: TMenuItem; Node: TTreeNode);
  var
    Y: Integer;
    SubNode: TTreeNode;
  begin
    for Y:=0 to Sub.Count-1 do
    begin
      SubNode := TreeView.Items.AddChildObject(Node, Sub[Y].Caption, Sub[Y]);
      if Sub[Y].Count > 0 then
        SubNivel(Sub[Y], SubNode);
    end;
  end;

begin
  Fecha := False;
  TreeView.Items.Clear;
  if Assigned(MItems) then
  begin
    for I:=0 to MItems.Count-1 do
    begin
      NewNode := TreeView.Items.AddChildObject(Nil, MItems[I].Caption, MItems[I]);
      if MItems[I].Count > 0 then
        SubNivel(MItems[I], NewNode);
    end;
    New.Enabled    := True;
    NewSub.Enabled := True;
    Delete.Enabled := True;
  end
  else
  begin
    New.Enabled    := False;
    NewSub.Enabled := False;
    Delete.Enabled := False;
  end;
  with TreeView do
  if Items.Count > 0 then
    begin
      Selected := Items.GetFirstNode;
      TreeViewChange(nil, Selected);
    end;
    SetStates;
end;

procedure TFormMenuEdit_i.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
     VK_F11:
       FormObjInsp.Show;
  end;
end;

end.
