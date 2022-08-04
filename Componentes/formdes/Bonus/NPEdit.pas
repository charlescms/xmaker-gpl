(*  GREATIS BONUS * NameProp                  *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit NPEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls;

type

  TPrefix = string[3];

  TfrmNameEditor = class(TForm)
    lblPrefix: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblPrefixTitle: TLabel;
    lblNameTitle: TLabel;
    lblClassTitle: TLabel;
    lblClassName: TLabel;
    btnMore: TButton;
    lsbPrefixes: TListBox;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    lblListPrefix: TLabel;
    btnFind: TButton;
    cmbName: TComboBox;
    procedure btnMoreClick(Sender: TObject);
    procedure lsbPrefixesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure cmbNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FNativeType,FComponentType: string;
    function GetPrefix: TPrefix;
    procedure SetComponentType(Value: string);
    procedure EnableOK;
  public
    { Public declarations }
    property NativeType: string read FNativeType write FNativeType;
    property ComponentType: string read FComponentType write SetComponentType;
  end;

var
  DlgLeft,DlgTop: Integer;

implementation

{$R *.DFM}

uses NPPref, NPFind;

procedure TfrmNameEditor.EnableOK;
begin
  with lsbPrefixes.Items do btnOK.Enabled:=cmbName.Text<>'';
end;

function TfrmNameEditor.GetPrefix: TPrefix;
var
  Idx: Integer;
begin
  with lsbPrefixes,Items do
  begin
    Idx:=IndexOf(Copy(NativeType,2,Pred(Length(NativeType))));
    if Idx<>-1 then Result:=TPrefix(Objects[Idx])
    else
      Idx:=IndexOf(Copy(ComponentType,2,Pred(Length(ComponentType))));
      if Idx<>-1 then Result:=TPrefix(Objects[Idx])
      else Result:='???';
  end;
end;

procedure TfrmNameEditor.SetComponentType(Value: string);
begin
  if Value<>FComponentType then
  begin
    FComponentType:=Value;
    lblPrefix.Caption:=GetPrefix;
    EnableOK;
  end;
end;

procedure TfrmNameEditor.btnMoreClick(Sender: TObject);
begin
  if btnMore.Caption='&Prefixes  >>' then
  begin
    btnMore.Caption:='&Prefixes  <<';
    btnNew.Visible:=True;
    btnEdit.Visible:=True;
    btnDelete.Visible:=True;
    lsbPrefixes.Visible:=True;
    lblListPrefix.Visible:=True;
    ClientHeight:=lsbPrefixes.Top+lsbPrefixes.Height+lsbPrefixes.Left;
  end
  else
  begin
    ClientHeight:=btnOK.Top+btnOK.Height+btnOK.Left;
    btnMore.Caption:='&Prefixes  >>';
    btnNew.Visible:=False;
    btnEdit.Visible:=False;
    btnDelete.Visible:=False;
    lsbPrefixes.Visible:=False;
    lblListPrefix.Visible:=False;
  end;
end;

procedure TfrmNameEditor.lsbPrefixesClick(Sender: TObject);
begin
  with lsbPrefixes do
  try
    lblListPrefix.Caption:=TPrefix(Items.Objects[ItemIndex]);
  except
  end;
end;

procedure TfrmNameEditor.FormShow(Sender: TObject);
begin
  Left:=DlgLeft;
  Top:=DlgTop;
  lblPrefix.Caption:=GetPrefix;
  ClientHeight:=btnOK.Top+btnOK.Height+btnOK.Left;
  lsbPrefixes.ItemIndex:=0;
  lsbPrefixesClick(nil);
  EnableOK;
end;

procedure TfrmNameEditor.btnNewClick(Sender: TObject);
var
  Idx: Integer;
begin
  with lsbPrefixes,Items,TfrmPrefixEditor.Create(Self) do
  try
    if NativeType<>ComponentType then
      edtClass.Text:=Copy(NativeType,2,Pred(Length(NativeType)));
    ShowModal;
    if ModalResult=mrOK then
      if IndexOf(edtClass.Text)<>-1 then
        MessageBox(Self.Handle,
          PChar('Class '+edtClass.Text+' already registered.'),
          'Name property editor',MB_OK or MB_ICONHAND)
      else
      begin
        Idx:=IndexOfObject(Pointer(TPrefix(edtPrefix.Text)));
        if Idx<>-1 then
          MessageBox(Self.Handle,
            PChar('Prefix '+edtPrefix.Text+' already registered.'#13'('+Strings[Idx]+')'),
            'Name property editor',MB_OK or MB_ICONHAND)
        else
        begin
          ItemIndex:=lsbPrefixes.Items.AddObject(edtClass.Text,Pointer(TPrefix(edtPrefix.Text)));
          lsbPrefixesClick(nil);
          lblPrefix.Caption:=GetPrefix;
          EnableOK;
        end;
      end;
  finally
    Free;
  end;
end;

procedure TfrmNameEditor.btnDeleteClick(Sender: TObject);
var
  Idx: Integer;
begin
  with lsbPrefixes do
    if MessageBox(Self.Handle,
      PChar('Delete "'+Items[ItemIndex]+' - '+TPrefix(Items.Objects[ItemIndex])+'"?'),
      'Name property editor',MB_YESNO or MB_ICONQUESTION)=ID_YES then
    begin
      Idx:=ItemIndex;
      Items.Delete(ItemIndex);
      if Idx>Pred(Items.Count) then Idx:=Pred(Items.Count);
      ItemIndex:=Idx;
      lsbPrefixesClick(nil);
      lblPrefix.Caption:=GetPrefix;
      EnableOK;
    end;
end;

procedure TfrmNameEditor.btnEditClick(Sender: TObject);
var
  Idx,OldIdx: Integer;
begin
  with lsbPrefixes,Items,TfrmPrefixEditor.Create(Self) do
  try
    OldIdx:=ItemIndex;
    edtClass.Text:=Items[ItemIndex];
    edtPrefix.Text:=TPrefix(Objects[ItemIndex]);
    ShowModal;
    if ModalResult=mrOK then
      if (IndexOf(edtClass.Text)<>-1) and (IndexOf(edtClass.Text)<>OldIdx) then
        MessageBox(Self.Handle,
          PChar('Class '+edtClass.Text+' already registered.'),
          'Name property editor',MB_OK or MB_ICONHAND)
      else
      begin
        Idx:=IndexOfObject(Pointer(TPrefix(edtPrefix.Text)));
        if (Idx<>-1) and (Idx<>OldIdx) then
          MessageBox(Self.Handle,
            PChar('Prefix '+edtPrefix.Text+' already registered.'#13'('+Strings[Idx]+')'),
            'Name property editor',MB_OK or MB_ICONHAND)
        else
        begin
          Delete(OldIdx);
          ItemIndex:=lsbPrefixes.Items.AddObject(edtClass.Text,Pointer(TPrefix(edtPrefix.Text)));
          lsbPrefixesClick(nil);
          lblPrefix.Caption:=GetPrefix;
          EnableOK;
        end;
      end;
  finally
    Free;
  end;
end;

procedure TfrmNameEditor.btnFindClick(Sender: TObject);
var
  Idx: Integer;
begin
  with TfrmFindPrefix.Create(Self) do
  try
    ShowModal;
    if ModalResult=mrOK then
      with lsbPrefixes,Items do
      begin
        Idx:=IndexOfObject(Pointer(TPrefix(edtPrefix.Text)));
        if Idx=-1 then
          MessageBox(Self.Handle,
            PChar('Prefix "'+edtPrefix.Text+'" not found.'),
            'Name property editor',MB_OK or MB_ICONINFORMATION)
        else
        begin
          ItemIndex:=Idx;
          lsbPrefixesClick(nil);
        end;
      end;
  finally
    Free;
  end;
end;

procedure TfrmNameEditor.cmbNameChange(Sender: TObject);
begin
  EnableOK;
end;

procedure TfrmNameEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dlgleft:=Left;
  DlgTop:=Top;
end;

end.
