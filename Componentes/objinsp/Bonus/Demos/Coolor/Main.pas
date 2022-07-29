(*  GREATIS BONUS * TCoolorDialog             *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Coolor, StdCtrls, IniFiles, ExtCtrls, ShellAPI, Colors;

type
  TfrmDemo = class(TForm)
    btnExecute: TButton;
    cmpCoolorDialog: TCoolorDialog;
    rgrActivePage: TRadioGroup;
    grbVisiblePages: TGroupBox;
    chbVGA: TCheckBox;
    chbInternet: TCheckBox;
    chbHSB: TCheckBox;
    chbRGB: TCheckBox;
    chbCMY: TCheckBox;
    chbGray: TCheckBox;
    chbWindows: TCheckBox;
    chbInfo: TCheckBox;
    chbHelpButton: TCheckBox;
    chbAutoHelpContext: TCheckBox;
    pnlColor: TPanel;
    pnlReferenceColor: TPanel;
    lblReferenceColor: TLabel;
    lblColor: TLabel;
    btnExit: TButton;
    lblCopyright: TLabel;
    lblHTTP: TLabel;
    lblCaption: TLabel;
    edtCaption: TEdit;
    btnShow: TButton;
    chbCMYK: TCheckBox;
    chbAutoApply: TCheckBox;
    chbStayOnTop: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure lblHTTPClick(Sender: TObject);
    procedure cmpCoolorDialogApply(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure cmpCoolorDialogGetCMYK(Sender: TObject;
      var CMYKColor: TCMYKColor);
    procedure cmpCoolorDialogSetCMYK(Sender: TObject;
      var CMYKColor: TCMYKColor);
  private
    { Private declarations }
    function ApplicationHelp(Command: Word; Data: Longint; var CallHelp: Boolean): Boolean;
  public
    { Public declarations }
  end;

var
  frmDemo: TfrmDemo;

implementation

{$R *.DFM}

function TfrmDemo.ApplicationHelp(Command: Word; Data: Longint; var CallHelp: Boolean): Boolean;
begin
  Result:=True;
  CallHelp:=False;
  ShowMessage('Help system call'#13'Help context = '+IntToStr(Data));
end;

procedure TfrmDemo.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // setting help emulation event
  Application.OnHelp:=ApplicationHelp;
  // loading user colors from IniFile
  with cmpCoolorDialog,TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini')) do
  try
    for i:=1 to UserColorCount do
      UserColors[i]:=RGBHexToColor(ReadString('My colors',IntToStr(i),ColorToRGBHex(clSilver)));
  finally
    Free;
  end;
end;

procedure TfrmDemo.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  // saving user colors to IniFile
  with cmpCoolorDialog,TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini')) do
  try
    for i:=1 to UserColorCount do
      WriteString('My colors',IntToStr(i),ColorToRGBHex(UserColors[i]));
  finally
    Free;
  end;
end;

procedure TfrmDemo.btnExecuteClick(Sender: TObject);
var
  i: Integer;
begin
  with cmpCoolorDialog do
  begin
    // setting properties from controls
    AutoApply:=chbAutoApply.Checked;
    ActivePage:=TDialogPage(rgrActivePage.ItemIndex);
    VisiblePages:=[];
    HelpButton:=chbHelpButton.Checked;
    AutoHelpContext:=chbAutoHelpContext.Checked;
    with grbVisiblePages do
      for i:=0 to Pred(ControlCount) do
        with Controls[i] as TCheckBox do
          if Checked then VisiblePages:=VisiblePages+[TDialogPage(i)];
    ReferenceColor:=pnlReferenceColor.Color;
    Color:=pnlColor.Color;
    Caption:=edtCaption.Text;
    // executing TCoolorDialog
    if Execute then
    begin
      // showing color parameters
      with HSBColor,RGBColor,CMYKColor do
        ShowMessage(
             'HSB      '#9'Hue='+IntToStr(Hue)+', Saturation='+IntToStr(Saturation)+', Brightness='+IntToStr(Brightness)+
          #13'RGB      '#9'Red='+IntToStr(Red)+', Green='+IntToStr(Green)+', Blue='+IntToStr(Blue)+
          #13'CMYK    '#9'Cyan='+IntToStr(Cyan)+', Magenta='+IntToStr(Magenta)+', Yellow='+IntToStr(Yellow)+', Black='+IntToStr(Black)+
          #13'RBGHex  '#9+RGBHex+
          #13'HTML    '#9+HTMLColor);
    end;
    rgrActivePage.ItemIndex:=Integer(ActivePage);
  end;
end;

procedure TfrmDemo.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmDemo.lblHTTPClick(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(lblHTTP.Caption),'','',SW_SHOWMAXIMIZED);
end;

procedure TfrmDemo.cmpCoolorDialogApply(Sender: TObject);
begin
  with cmpCoolorDialog do
  begin
    pnlReferenceColor.Color:=ReferenceColor;
    pnlReferenceColor.Update;
    pnlColor.Color:=Color;
    pnlColor.Update;
    rgrActivePage.ItemIndex:=Integer(ActivePage);
  end;
end;

procedure TfrmDemo.btnShowClick(Sender: TObject);
var
  i: Integer;
begin
  with cmpCoolorDialog do
  begin
    // setting properties from controls
    AutoApply:=chbAutoApply.Checked;
    StayOnTop:=chbStayOnTop.Checked;
    ActivePage:=TDialogPage(rgrActivePage.ItemIndex);
    VisiblePages:=[];
    HelpButton:=chbHelpButton.Checked;
    AutoHelpContext:=chbAutoHelpContext.Checked;
    with grbVisiblePages do
      for i:=0 to Pred(ControlCount) do
        with Controls[i] as TCheckBox do
          if Checked then VisiblePages:=VisiblePages+[TDialogPage(Tag)];
    ReferenceColor:=pnlReferenceColor.Color;
    Color:=pnlColor.Color;
    Caption:=edtCaption.Text;
    // show TCoolorDialog
    Show;
  end;
end;

procedure TfrmDemo.cmpCoolorDialogGetCMYK(Sender: TObject;
  var CMYKColor: TCMYKColor);
begin
  ShowMessage('GET');
end;

procedure TfrmDemo.cmpCoolorDialogSetCMYK(Sender: TObject;
  var CMYKColor: TCMYKColor);
begin
  ShowMessage('SET');
end;

end.
