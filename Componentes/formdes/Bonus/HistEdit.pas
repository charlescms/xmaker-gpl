(*  GREATIS BONUS * THistoryEdit              *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit HistEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  THistoryEdit = class(TCustomComboBox)
  private
    { Private declarations }
    Pause: Boolean;
    fAutoAdd: Boolean;
    fActive: Boolean;
    fCaseSens: Boolean;
    fLimit: Integer;
    function Search(Txt: string; var Item: string): Boolean;
    procedure SetLimit(Value: Integer);
  protected
    { Protected declarations }
    procedure Change; override;
    procedure Click; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure AddHistory;
  published
    { Published declarations }
    property AutoAdd: Boolean read fAutoAdd write fAutoAdd;
    property Active: Boolean read fActive write fActive;
    property CaseSens: Boolean read fCaseSens write fCaseSens;
    property Limit: Integer read fLimit write SetLimit;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property Hint;
    property ImeMode;
    property ImeName;
    property Items;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
  end;

implementation

constructor THistoryEdit.Create(AOwner: TComponent);
begin
  inherited;
  Sorted:=False;
  Style:=csDropDown;
  fCaseSens:=True;
  fActive:=True;
  fLimit:=100;
end;

procedure THistoryEdit.Change;
var
  S: string;
  TextLen: Integer;
begin
  inherited;
  if not Pause and Active then
  begin
    Search(Text,S);
    if S<>'' then
    begin
      TextLen:=Length(Text);
      Text:=S;
      SelStart:=TextLen;
      SelLength:=Length(S)-TextLen;
    end;
  end;
  Pause:=False;
end;

procedure THistoryEdit.Click;
begin
  inherited;
  AddHistory;
end;

procedure THistoryEdit.DoExit;
begin
  inherited;
  if fAutoAdd then AddHistory;
end;

procedure THistoryEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_BACK,VK_DELETE: Pause:=True;
  end;
end;

function THistoryEdit.Search(Txt: string; var Item: string): Boolean;
var
  i: Integer;
begin
  Item:='';
  with Items do
    if Txt<>'' then
      for i:=0 to Pred(Count) do
        if (LStrCmp(PChar(Copy(Strings[i],1,Length(Txt))),PChar(Txt))=0) and fCaseSens or
          (LStrCmpI(PChar(Copy(Strings[i],1,Length(Txt))),PChar(Txt))=0) and not fCaseSens then
          begin
            Item:=Items[i];
            Break;
          end;
  Result:=(Txt<>'') and (Txt=Item);
end;

procedure THistoryEdit.SetLimit(Value: Integer);
begin
  if fLimit<>Value then
  begin
    fLimit:=Value;
    with Items do
      while Count>fLimit do Delete(Pred(Count));
  end;
end;

procedure THistoryEdit.AddHistory;
var
  S: string;
begin
  if Text<>'' then
    if Search(Text,S) then
    begin
      Items.Move(Items.IndexOf(Text),0);
      ItemIndex:=0;
      Text:=S;
    end
    else
    begin
      while Items.Count>Limit do Items.Delete(Pred(Items.Count));
      Items.Insert(0,Text);
    end;
end;

end.
