unit find;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfrmFind = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    cbFindText: TComboBox;
    GroupBox1: TGroupBox;
    cbMatchCase: TCheckBox;
    cbWholeWord: TCheckBox;
    GroupBox3: TGroupBox;
    rbGlobal: TRadioButton;
    rbSelectedOnly: TRadioButton;
    GroupBox2: TGroupBox;
    rbForward: TRadioButton;
    rbBackward: TRadioButton;
    GroupBox4: TGroupBox;
    rbFromCursor: TRadioButton;
    rbEntireScope: TRadioButton;
    btnFind: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    EmTodos: TCheckBox;
    procedure btnFindClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFind: TfrmFind;

implementation

{$R *.DFM}

uses Rotinas;

procedure TfrmFind.btnFindClick(Sender: TObject);
begin
  cbFindText.Items.Add( cbFindText.Text );
  Lista_Find_G.Clear;
  Lista_Find_G.AddStrings(cbFindText.Items);
end;

procedure TfrmFind.FormActivate(Sender: TObject);
begin
  cbFindText.SetFocus;
end;

procedure TfrmFind.FormShow(Sender: TObject);
begin
  if cbFindText.Items.Count = 0 then
    cbFindText.Items.AddStrings(Lista_Find_G);
end;

end.
