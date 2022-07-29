unit CHILDWIN;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, ComCtrls,
  OleCtrls, SHDocVw_TLB, SysUtils, Ajuda, SHDocVw;

type
  TEnabled = record
    FBack:Boolean;
    FForward:Boolean;
  end;
  TIEWindow = class(TForm)
    WebBrowser1: TWebBrowser;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebBrowser1CommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebBrowser1TitleChange(Sender: TObject;
      const Text: WideString);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure WebBrowser1NavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1StatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure StatusBar1Resize(Sender: TObject);
  private
    { Private éŒ¾ }
    E:TEnabled;
  public
    { Public éŒ¾ }
  end;

implementation

{$R *.dfm}

procedure TIEWindow.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
begin
  i := FormAjuda.TabControl1.Tabs.IndexOfObject(TObject(Self));
  FormAjuda.TabControl1.Tabs.Delete(i);
  if MDIChildCount = 1 then
  begin
    FormAjuda.BackButton.Enabled := False;
    FormAjuda.ForwardButton.Enabled := False;
  end;
  Action := caFree;
end;

procedure TIEWindow.WebBrowser1CommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
  case Command of
    CSC_NAVIGATEFORWARD:
    begin
      E.FForward := Enable;
      FormAjuda.ForwardButton.Enabled := Enable;
    end;
    CSC_NAVIGATEBACK:
    begin
      E.FBack := Enable;
      FormAjuda.BackButton.Enabled := Enable;
    end;
  end;
end;

procedure TIEWindow.FormActivate(Sender: TObject);
var
  i:integer;
begin
  i := FormAjuda.TabControl1.Tabs.IndexOfObject(TObject(Self));
  FormAjuda.TabControl1.TabIndex := i;
  FormAjuda.BackButton.Enabled := E.FBack;
  FormAjuda.ForwardButton.Enabled := E.FForward;
end;

procedure TIEWindow.FormCreate(Sender: TObject);
begin
  FormAjuda.TabControl1.Tabs.AddObject('',TObject(Self));
end;

procedure TIEWindow.WebBrowser1TitleChange(Sender: TObject;
  const Text: WideString);
var
  i:integer;
begin
  Self.Caption := Text;
  i := FormAjuda.TabControl1.Tabs.IndexOfObject(TObject(Self));
  if i > -1 then
  begin
    FormAjuda.TabControl1.Tabs.Strings[i] := Text;
  end;
end;

procedure TIEWindow.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
  Child:TIEWindow;
begin
  Child := TIEWindow.Create(Application);
  ppDisp := Child.WebBrowser1.Application;
end;

procedure TIEWindow.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  FormAjuda.Edit1.Text := WebBrowser1.LocationURL;
end;

procedure TIEWindow.WebBrowser1StatusTextChange(Sender: TObject;
  const Text: WideString);
begin
  StatusBar1.Panels.Items[0].Text := Text;
end;

procedure TIEWindow.StatusBar1Resize(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Width := StatusBar1.Width - 100;
end;

end.
