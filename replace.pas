unit Replace;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TFrmReplace = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    cbFindText: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    cbReplace: TComboBox;
    btnHelp: TButton;
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
    EmTodos: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReplace: TFrmReplace;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFrmReplace.FormActivate(Sender: TObject);
begin
   cbFindText.SetFocus;
end;

procedure TFrmReplace.btnOKClick(Sender: TObject);
begin
  cbFindText.Items.Add( cbFindText.Text );
  cbReplace.Items.Add( cbReplace.Text );
  Lista_Find_G.Clear;
  Lista_Find_G.AddStrings(cbFindText.Items);
  Lista_Subst_G.Clear;
  Lista_Subst_G.AddStrings(cbReplace.Items);
end;

procedure TFrmReplace.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmReplace.FormShow(Sender: TObject);
begin
  if cbFindText.Items.Count = 0 then
    cbFindText.Items.AddStrings(Lista_Find_G);
  if cbReplace.Items.Count = 0 then
    cbReplace.Items.AddStrings(Lista_Subst_G);
end;

end.
