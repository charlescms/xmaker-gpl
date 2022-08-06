{
   Programa.: OpcRel.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit OpcRel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, Grids, Spin, ComCtrls, Mask, Buttons,
  ToolWin;

type
  TFormOpcRel = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label9: TLabel;
    GroupBox2: TGroupBox;
    imgLandScape: TImage;
    imgPortrait: TImage;
    RB1: TRadioButton;
    RB2: TRadioButton;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComB1: TComboBox;
    E1: TEdit;
    E2: TEdit;
    EdTitulo: TEdit;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CB5: TCheckBox;
    E3: TEdit;
    E4: TEdit;
    E5: TEdit;
    E6: TEdit;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    E7: TEdit;
    Edit1: TEdit;
    Panel8: TPanel;
    SB1: TSpeedButton;
    SB2: TSpeedButton;
    TabSheet4: TTabSheet;
    GrupoTotalizacao: TGroupBox;
    CTotalizar: TCheckBox;
    CQuantificar: TCheckBox;
    GrupoQuebra: TGroupBox;
    CQuebra: TCheckBox;
    CSintetizar: TCheckBox;
    CSubtotalizar: TCheckBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    CDesigner: TCheckBox;
    procedure RB1Click(Sender: TObject);
    procedure RB2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComB1Click(Sender: TObject);
    procedure CB5Click(Sender: TObject);
    procedure SB1Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOpcRel: TFormOpcRel;

implementation

{$R *.DFM}

uses FR_Prntr, FR_Utils;

procedure TFormOpcRel.RB1Click(Sender: TObject);
begin
  ImgPortrait.Show;
  ImgLandscape.Hide;
end;

procedure TFormOpcRel.RB2Click(Sender: TObject);
begin
  ImgLandscape.Show;
  ImgPortrait.Hide;
end;

procedure TFormOpcRel.FormActivate(Sender: TObject);
begin
  if RB1.Checked then RB1Click(nil) else RB2Click(nil);
  ComB1Click(nil); CB5Click(nil);
  ComB1.Perform(CB_SETDROPPEDWIDTH, 200, 0);
end;

procedure TFormOpcRel.ComB1Click(Sender: TObject);
begin
  frEnableControls([Label1, Label2, E1, E2],
    Prn.PaperSizes[ComB1.ItemIndex] = $100);
end;

procedure TFormOpcRel.CB5Click(Sender: TObject);
begin
  frEnableControls([Label3, Label4, Label5, Label6, E3, E4, E5, E6],
    not CB5.Checked);
end;

procedure TFormOpcRel.SB1Click(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(Edit1.Text);
  Inc(i);
  Edit1.Text := IntToStr(i);
end;

procedure TFormOpcRel.SB2Click(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(Edit1.Text);
  Dec(i);
  if i < 0 then i := 0;
  Edit1.Text := IntToStr(i);
end;

end.
