unit Ajuda;

interface

uses
  Windows, Forms, StdCtrls, Classes, Controls, ExtCtrls, ComCtrls, ToolWin,
  ImgList, OleCtrls, SHDocVw, Sysutils;

type
  TFormAjuda = class(TForm)
    Panel3: TPanel;
    ImageList1: TImageList;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BackButton: TToolButton;
    ForwardButton: TToolButton;
    HomeButton: TToolButton;
    RefreshButton: TToolButton;
    StopButton: TToolButton;
    ToolBar2: TToolBar;
    Edit1: TEdit;
    NavigateButton: TToolButton;
    WebBrowser1: TWebBrowser;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1CommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    procedure WebBrowser1NavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1StatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure BackButtonClick(Sender: TObject);
    procedure ForwardButtonClick(Sender: TObject);
    procedure HomeButtonClick(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure NavigateButtonClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ToolBar2Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    URL: String
  end;

var
  FormAjuda: TFormAjuda;

implementation

{$R *.DFM}

procedure TFormAjuda.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate(URL);
end;

procedure TFormAjuda.WebBrowser1CommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
  case Command of
    CSC_NAVIGATEFORWARD:
    begin
      ForwardButton.Enabled := Enable;
    end;
    CSC_NAVIGATEBACK:
    begin
      BackButton.Enabled := Enable;
    end;
  end;
end;

procedure TFormAjuda.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  Edit1.Text := WebBrowser1.LocationURL;
end;

procedure TFormAjuda.WebBrowser1StatusTextChange(Sender: TObject;
  const Text: WideString);
begin
  StatusBar1.Panels.Items[0].Text := Text;
end;

procedure TFormAjuda.BackButtonClick(Sender: TObject);
begin
  if WebBrowser1.Document <> nil then
    WebBrowser1.GoBack;
end;

procedure TFormAjuda.ForwardButtonClick(Sender: TObject);
begin
  if WebBrowser1.Document <> nil then
    WebBrowser1.GoForward;
end;

procedure TFormAjuda.HomeButtonClick(Sender: TObject);
begin
  if WebBrowser1.Document <> nil then
    WebBrowser1.GoHome;
end;

procedure TFormAjuda.RefreshButtonClick(Sender: TObject);
begin
  if WebBrowser1.Document <> nil then
    WebBrowser1.Refresh;
end;

procedure TFormAjuda.StopButtonClick(Sender: TObject);
begin
  if WebBrowser1.Busy then
    WebBrowser1.Stop;
end;

procedure TFormAjuda.NavigateButtonClick(Sender: TObject);
begin
  if Trim(Edit1.Text) = '' then
    Edit1.Text := 'about:blank';
  URL := Edit1.Text;
  WebBrowser1.Navigate(URL);
end;

procedure TFormAjuda.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
    NavigateButtonClick(Self);
end;

procedure TFormAjuda.ToolBar2Resize(Sender: TObject);
begin
  Edit1.Width := ToolBar2.Width - 25;
end;

end.
