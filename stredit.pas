
{*******************************************************}
{                                                       }
{       Delphi Visual Component Library                 }
{       TStrings property editor dialog                 }
{                                                       }
{       Copyright (c) 1999 Borland International        }
{                                                       }
{*******************************************************}

unit StrEdit;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Menus;

type
  TStrEditDlg = class(TForm)
    LineCount: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    OKButton: TButton;
    CancelButton: TButton;
    Memo: TRichEdit;
    StringEditorMenu: TPopupMenu;
    LoadItem: TMenuItem;
    SaveItem: TMenuItem;
    CodeEditorItem: TMenuItem;
    Bevel1: TBevel;
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure UpdateStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CodeWndBtnClick(Sender: TObject);
  private
    SingleLine: string;
    MultipleLines: string;
    FModified: Boolean;
  end;

implementation

{$R *.DFM}

uses SysUtils, TypInfo;

{ TStrEditDlg }

procedure TStrEditDlg.FileOpen(Sender: TObject);
begin
  with OpenDialog do
    if Execute then Memo.Lines.LoadFromFile(FileName);
end;

procedure TStrEditDlg.FileSave(Sender: TObject);
begin
  SaveDialog.FileName := OpenDialog.FileName;
  with SaveDialog do
    if Execute then Memo.Lines.SaveToFile(FileName);
end;

procedure TStrEditDlg.UpdateStatus(Sender: TObject);
var
  Count: Integer;
  LineText: string;
begin
  if Sender = Memo then FModified := True;
  Count := Memo.Lines.Count;
  if Count = 1 then LineText := SingleLine
  else LineText := MultipleLines;
  LineCount.Caption := Format('%d %s', [Count, LineText]);
end;

procedure TStrEditDlg.FormCreate(Sender: TObject);
begin
  //HelpContext := hcDStringListEditor;

  //OpenDialog.HelpContext := hcDStringListLoad;
  //SaveDialog.HelpContext := hcDStringListSave;
  SingleLine := 'linha';
  MultipleLines := 'linhas';
end;

procedure TStrEditDlg.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CancelButton.Click;
end;

procedure TStrEditDlg.CodeWndBtnClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

end.
