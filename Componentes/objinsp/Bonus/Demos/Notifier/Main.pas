(*  GREATIS BONUS * TNotifier                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Notifier, ExtCtrls;

type
  TfrmMain = class(TForm)
    cmpNotifier: TNotifier;
    memLog: TMemo;
    lblLog: TLabel;
    btnAddLabel: TButton;
    btnAddButton: TButton;
    btnAddEdit: TButton;
    lblInstructionDelete: TLabel;
    bvlLine: TBevel;
    lblInstructionAdd: TLabel;
    procedure cmpNotifierNotification(Sender: TObject;
      AComponent: TComponent; Operation: TOperation);
    procedure btnAddLabelClick(Sender: TObject);
    procedure btnAddButtonClick(Sender: TObject);
    procedure btnAddEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eveControlMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure InitCoords(Control: TControl);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.InitCoords(Control: TControl);
begin
  with Control do
  begin
    Left:=Random(Self.ClientWidth-Width);
    Top:=bvlLine.Top+bvlLine.Height+Random(Self.ClientHeight-bvlLine.Top-bvlLine.Height-Height);
  end;
end;

procedure TfrmMain.cmpNotifierNotification(Sender: TObject;
  AComponent: TComponent; Operation: TOperation);
var
  S: string;
begin
  S:=AComponent.ClassName;
  if Operation=opInsert then S:=S+' is added'
  else S:=S+' is deleted';
  memLog.Lines.Add(S);
end;

procedure TfrmMain.btnAddLabelClick(Sender: TObject);
var
  LBL: TLabel;
begin
  LBL:=TLabel.Create(Self);
  with LBL do
  begin
    Caption:='Label';
    InitCoords(LBL);
    OnMouseDown:=eveControlMouseDown;
    Parent:=Self;
  end;
end;

procedure TfrmMain.btnAddButtonClick(Sender: TObject);
var
  BTN: TButton;
begin
  BTN:=TButton.Create(Self);
  with BTN do
  begin
    Caption:='Button';
    InitCoords(BTN);
    OnMouseDown:=eveControlMouseDown;
    Parent:=Self;
  end;
end;

procedure TfrmMain.btnAddEditClick(Sender: TObject);
var
  EDT: TEdit;
begin
  EDT:=TEdit.Create(Self);
  with EDT do
  begin
    Text:='Edit';
    InitCoords(EDT);
    OnMouseDown:=eveControlMouseDown;
    Parent:=Self;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Randomize;
end;

procedure TfrmMain.eveControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Sender.Free;
end;

end.
