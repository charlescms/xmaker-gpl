(*  GREATIS BONUS * Life                      *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit LifeProp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Registry;

type
  TfrmLifeProperties = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    rgrColors: TRadioGroup;
    grbDelay: TGroupBox;
    chbNoDelay: TCheckBox;
    edtDelay: TEdit;
    udnDelay: TUpDown;
    lblDelay: TLabel;
    lblCellSize: TLabel;
    edtCellSize: TEdit;
    udnCellSize: TUpDown;
    lblRandRise: TLabel;
    cmbRandRise: TComboBox;
    btnAbout: TButton;
    rgrCellShape: TRadioGroup;
    chbPureConway: TCheckBox;
    chbClosed: TCheckBox;
    procedure chbNoDelayClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtKeyPress(Sender: TObject; var Key: Char);
    procedure btnAboutClick(Sender: TObject);
  end;

var
  frmLifeProperties: TfrmLifeProperties;

implementation

uses About;

const
  RegName = 'SOFTWARE\Greatis';
  SecName = 'Life Screen Saver';

{$R *.DFM}

procedure TfrmLifeProperties.chbNoDelayClick(Sender: TObject);
begin
  lblDelay.Enabled:=not chbNoDelay.Checked;
  edtDelay.Enabled:=not chbNoDelay.Checked;
  udnDelay.Enabled:=not chbNoDelay.Checked;
end;

procedure TfrmLifeProperties.btnClick(Sender: TObject);
begin
  if ModalResult=mrOK then
    with TRegIniFile.Create(RegName) do
    try
      WriteInteger(SecName+'\Options','Color set',rgrColors.ItemIndex);
      WriteBool(SecName+'\Options','Delay',not chbNoDelay.Checked);
      WriteString(SecName+'\Options','Delay value',edtDelay.Text);
      WriteString(SecName+'\Options','Cell size',edtCellSize.Text);
      WriteInteger(SecName+'\Options','Cell shape',rgrCellShape.ItemIndex);
      WriteInteger(SecName+'\Options','Random',cmbRandRise.ItemIndex);
      WriteBool(SecName+'\Options','Pure Conway',chbPureConway.Checked);
      WriteBool(SecName+'\Options','Closed',chbClosed.Checked);
    finally
      Free;
    end;
  Close;
end;

procedure TfrmLifeProperties.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=ExtractFilePath(ParamStr(0))+'Greatis Life.hlp';
  with TRegIniFile.Create(RegName) do
  try
    WriteString(SecName,'@Name','Life Screen Saver');
    WriteString(SecName,'@Path',ParamStr(0));
    WriteString(SecName,'@Version','3');
    rgrColors.ItemIndex:=ReadInteger(SecName+'\Options','Color set',0);
    chbNoDelay.Checked:=not ReadBool(SecName+'\Options','Delay',True);
    udnDelay.Position:=ReadInteger(SecName+'\Options','Delay value',10);
    udnCellSize.Position:=ReadInteger(SecName+'\Options','Cell size',10);
    rgrCellShape.ItemIndex:=ReadInteger(SecName+'\Options','Cell shape',0);
    cmbRandRise.ItemIndex:=ReadInteger(SecName+'\Options','Random',3);
    chbPureConway.Checked:=ReadBool(SecName+'\Options','Pure Conway',False);
    chbClosed.Checked:=ReadBool(SecName+'\Options','Closed',True);
    chbNoDelayClick(nil);
  finally
    Free;
  end;
end;

procedure TfrmLifeProperties.edtKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',Char(VK_BACK)]) then
  begin
    Key:=#0;
    MessageBeep(0);
  end;
end;

procedure TfrmLifeProperties.btnAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

end.
