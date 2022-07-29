{******************************************************************************}
{* WARNING:  JEDI VCL To CLX Converter generated unit.                        *}
{*           Manual modifications will be lost on next release.               *}
{******************************************************************************}

unit MainFormUnit;

interface

uses
  QWindows, QMessages, SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QComCtrls, QExtCtrls, JvQEmbeddedForms, JvQExControls, JvQComponent;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    JvEmbeddedFormPanel1: TJvEmbeddedFormPanel;
    JvEmbeddedFormPanel2: TJvEmbeddedFormPanel;
    JvEmbeddedInstanceFormPanel1: TJvEmbeddedInstanceFormPanel;
    Label1: TLabel;
    Label3: TLabel;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    btnDock: TButton;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnDockClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses DeepEmbeddedFormUnit, EmbeddedFormUnit;

{$R *.xfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
  Memo1.WordWrap := true;
  PageControl1.ActivePageIndex := 0;
end;

procedure TMainForm.btnDockClick(Sender: TObject);
begin
  if JvEmbeddedFormPanel1.IsLinkedFormDocked then
  begin
    JvEmbeddedFormPanel1.UnDockLinkedForm(fbsSizeable,poScreenCenter);
    btnDock.Caption := 'Show Docked';
  end
  else
  begin
    JvEmbeddedFormPanel1.DockLinkedForm;
    btnDock.Caption := 'Show Stand-Alone';
  end;
end;

end.

