unit TabOrdem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CheckLst, Menus;

type
  TFormTabOrdem = class(TForm)
    Bevel1: TBevel;
    LbTitulo: TLabel;
    TabList: TListBox;
    OKButton: TButton;
    CancelButton: TButton;
    BtnMoveParaBaixo: TSpeedButton;
    BtnMoveParaCima: TSpeedButton;
    TabList1: TCheckListBox;
    PopupMenu1: TPopupMenu;
    SelecionarTudo1: TMenuItem;
    DesmarcarTudo1: TMenuItem;
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure SelecionarTudo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTabOrdem: TFormTabOrdem;

implementation

{$R *.DFM}

procedure TFormTabOrdem.BtnMoveParaBaixoClick(Sender: TObject);
var
  Pos_i,Pos_f: Integer;
  Atual: String;
  ch_f: Boolean;
begin
  if TabList.Visible then
  begin
    if TabList.ItemIndex < 0 then
      exit;
    Pos_i := TabList.ItemIndex;
    Atual := TabList.Items[Pos_i];
    Pos_f := Pos_i + 1;
    if Pos_f > TabList.Items.Count-1 then
      Pos_f := 0;
    TabList.Items[Pos_i] := TabList.Items[Pos_f];
    TabList.Items[Pos_f] := Atual;
    TabList.ItemIndex := Pos_f;
  end
  else
  begin
    if TabList1.ItemIndex < 0 then
      exit;
    Pos_i := TabList1.ItemIndex;
    Atual := TabList1.Items[Pos_i];
    ch_f  := TabList1.Checked[Pos_i];
    Pos_f := Pos_i + 1;
    if Pos_f > TabList1.Items.Count-1 then
      Pos_f := 0;
    TabList1.Items[Pos_i] := TabList1.Items[Pos_f];
    TabList1.Checked[Pos_i] := TabList1.Checked[Pos_f];
    TabList1.Items[Pos_f] := Atual;
    TabList1.Checked[Pos_f] := ch_f;
    TabList1.ItemIndex := Pos_f;
  end;
end;

procedure TFormTabOrdem.BtnMoveParaCimaClick(Sender: TObject);
var
  Pos_i,Pos_f: Integer;
  Atual: String;
  ch_f: Boolean;
begin
  if TabList.Visible then
  begin
    if TabList.ItemIndex < 0 then
      exit;
    Pos_i := TabList.ItemIndex;
    Atual := TabList.Items[Pos_i];
    Pos_f := Pos_i - 1;
    if Pos_f < 0 then
      Pos_f := TabList.Items.Count-1;
    TabList.Items[Pos_i] := TabList.Items[Pos_f];
    TabList.Items[Pos_f] := Atual;
    TabList.ItemIndex := Pos_f;
  end
  else
  begin
    if TabList1.ItemIndex < 0 then
      exit;
    Pos_i := TabList1.ItemIndex;
    Atual := TabList1.Items[Pos_i];
    ch_f  := TabList1.Checked[Pos_i];
    Pos_f := Pos_i - 1;
    if Pos_f < 0 then
      Pos_f := TabList1.Items.Count-1;
    TabList1.Items[Pos_i] := TabList1.Items[Pos_f];
    TabList1.Checked[Pos_i] := TabList1.Checked[Pos_f];
    TabList1.Items[Pos_f] := Atual;
    TabList1.Checked[Pos_f] := ch_f;
    TabList1.ItemIndex := Pos_f;
  end;
end;

procedure TFormTabOrdem.SelecionarTudo1Click(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to TabList1.Items.Count-1 do
    if TControl(Sender).Tag = 10 then
      TabList1.Checked[I] := True
    else if TControl(Sender).Tag = 20 then
      TabList1.Checked[I] := False;
end;

end.
