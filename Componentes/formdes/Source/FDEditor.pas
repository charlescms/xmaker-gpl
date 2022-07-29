(*  GREATIS FORM DESIGNER                         *)
(*  unit version 3.80.013                         *)
(*  Copyright (C) 2001-2005 Greatis Software      *)
(*  http://www.greatis.com/delphicb/formdes/      *)
(*  http://www.greatis.com/delphicb/formdes/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit FDEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FDMain;

type
  TfrmFDEditor = class(TForm)
    btnDelete: TButton;
    btnAdd: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    lsbLocked: TListBox;
    rgrControls: TRadioGroup;
    lsbProtected: TListBox;
    lsbTransparent: TListBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure rgrControlsClick(Sender: TObject);
    procedure lsbProtectedClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateButtons;
    procedure UpdateLists;
    function ActiveList: TListBox;
    procedure FillList(AOwner: TComponent; ListType: TListType; Target: TStrings; Exclude: TStrings; AName: string);
  public
    { Public declarations }
    FormDesigner: TCustomFormDesigner;
    constructor Create(AOwner: TComponent); override;
  end;

function EditLists(AFormDesigner: TCustomFormDesigner; DefaultList: TListType): Boolean;

implementation

{$IFDEF VER100}
{$DEFINE NOFRAMES}
{$ENDIF}
{$IFDEF VER110}
{$DEFINE NOFRAMES}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE NOFRAMES}
{$ENDIF}
{$IFDEF VER125}
{$DEFINE NOFRAMES}
{$ENDIF}

{$R *.DFM}

uses FDAdd;

procedure TfrmFDEditor.UpdateButtons;
begin
  with ActiveList,Items do
  begin
    btnDelete.Enabled:=ItemIndex<>-1;
    btnClear.Enabled:=Count>0;
  end;
end;

procedure TfrmFDEditor.UpdateLists;
begin
  lsbLocked.Visible:=rgrControls.ItemIndex=0;
  lsbProtected.Visible:=rgrControls.ItemIndex=1;
  lsbTransparent.Visible:=rgrControls.ItemIndex=2;
  with ActiveList do
    if (Items.Count>0) and (ItemIndex=-1) then ItemIndex:=0;
  UpdateButtons;
end;

function TfrmFDEditor.ActiveList: TListBox;
begin
  case rgrControls.ItemIndex of
    0: Result:=lsbLocked;
    1: Result:=lsbProtected;
  else Result:=lsbTransparent;
  end;
end;

constructor TfrmFDEditor.Create(AOwner: TComponent);
begin
  inherited Create(Application);
end;

procedure TfrmFDEditor.FillList(AOwner: TComponent; ListType: TListType; Target: TStrings; Exclude: TStrings; AName: string);
var
  i: Integer;
begin
  with AOwner do
    for i:=0 to Pred(ComponentCount) do
      if not (Components[i] is TCustomFormDesigner) then
      begin
        if (not Assigned(Exclude) or (Exclude.IndexOf(Components[i].Name)=-1)) then
          Target.Add(AName+Components[i].Name);
        {$IFNDEF NOFRAMES}
        if Components[i] is TCustomFrame then
          FillList(Components[i],ListType,Target,Exclude,AName+Components[i].Name+'.');
        {$ENDIF}
      end;
end;

procedure TfrmFDEditor.btnAddClick(Sender: TObject);
var
  i: Integer;
begin
  with TfrmFDAdd.Create(Self) do
  try
    with lsbAddControls,Items do
    begin
      Clear;
      FillList(FormDesigner.ParentForm,TListType(rgrControls.ItemIndex),lsbAddControls.Items,ActiveList.Items,'');
      if ShowModal=mrOk then
        for i:=0 to Pred(Count) do
          if Selected[i] then
            ActiveList.Items.Add(Items[i]);
      with ActiveList do
        if ItemIndex=-1 then ItemIndex:=0;
    end;
  finally
    Free;
  end;
  UpdateButtons;
end;

procedure TfrmFDEditor.btnDeleteClick(Sender: TObject);
var
  I: Integer;
begin
  with ActiveList,Items do
    if ItemIndex<>-1 then
    begin
      I:=ItemIndex;
      Delete(I);
      if I>Pred(Count) then I:=Pred(Count);
      ItemIndex:=I;
    end;
  UpdateButtons;
end;

procedure TfrmFDEditor.FormShow(Sender: TObject);
begin
  UpdateLists;
  with ActiveList,Items do
    if Count>0 then ItemIndex:=0;
  UpdateButtons;
end;

procedure TfrmFDEditor.btnClearClick(Sender: TObject);
begin
  ActiveList.Items.Clear;
end;

procedure TfrmFDEditor.rgrControlsClick(Sender: TObject);
begin
  UpdateLists;
end;

procedure TfrmFDEditor.lsbProtectedClick(Sender: TObject);
begin
  UpdateButtons;
end;

function EditLists(AFormDesigner: TCustomFormDesigner; DefaultList: TListType): Boolean;
begin
  with TfrmFDEditor.Create(Application) do
  try
    FormDesigner:=AFormDesigner;
    if Assigned(FormDesigner) then
    begin
      Caption:=FormDesigner.Name;
      if Assigned(FormDesigner.Owner) then Caption:=FormDesigner.Owner.Name+'.'+Caption;
      rgrControls.ItemIndex:=Integer(DefaultList);
      lsbTransparent.Items.Assign(FormDesigner.TransparentControls);
      {$IFDEF TFD1COMPATIBLE}
      lsbLocked.Items.Assign(FormDesigner.FixedControls);
      {$ELSE}
      lsbLocked.Items.Assign(FormDesigner.LockedControls);
      {$ENDIF}
      lsbProtected.Items.Assign(FormDesigner.ProtectedControls);
      Result:=ShowModal=mrOk;
      if Result then
        with FormDesigner do
        begin
          TransparentControls.Assign(lsbTransparent.Items);
          {$IFDEF TFD1COMPATIBLE}
          FixedControls.Assign(lsbLocked.Items);
          {$ELSE}
          LockedControls.Assign(lsbLocked.Items);
          {$ENDIF}
          ProtectedControls.Assign(lsbProtected.Items);
        end;
    end
    else Result:=False;
  finally
    Free;
  end;
end;


end.
